#!/bin/bash

# ====================================================================
# AIModelHub - Automated Cleanup Script
# Version: 1.0
# Created: 2026-02-10
# Purpose: Clean logs, temporary files, and optimize project
# ====================================================================

set -e

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🧹 AIModelHub - Project Cleanup"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_ROOT"

# ====================================================================
# 1. Clean Log Files
# ====================================================================
echo "[1/5] Cleaning log files..."

# List log files before cleaning
echo "   Current log files:"
find . -name "*.log" -type f -not -path "*/node_modules/*" -exec du -h {} \; | column -t

# Option to clean logs
read -p "   Remove all log files? (y/N): " -n 1 -r CLEAN_LOGS
echo ""

if [[ $CLEAN_LOGS =~ ^[Yy]$ ]]; then
    find . -name "*.log" -type f -not -path "*/node_modules/*" -exec rm -f {} \;
    echo "   ✅ Log files removed"
else
    echo "   ℹ️  Keeping log files"
fi

# ====================================================================
# 2. Clean Temporary Files
# ====================================================================
echo ""
echo "[2/5] Cleaning temporary files..."

TEMP_COUNT=$(find . -type f \( -name "*.tmp" -o -name "*.bak" -o -name "*~" \) -not -path "*/node_modules/*" | wc -l)
echo "   Found $TEMP_COUNT temporary files"

if [ "$TEMP_COUNT" -gt 0 ]; then
    find . -type f \( -name "*.tmp" -o -name "*.bak" -o -name "*~" \) -not -path "*/node_modules/*" -delete
    echo "   ✅ Temporary files removed"
else
    echo "   ℹ️  No temporary files found"
fi

# ====================================================================
# 3. Clean Python Cache
# ====================================================================
echo ""
echo "[3/5] Cleaning Python cache..."

PYCACHE_COUNT=$(find . -type d -name "__pycache__" | wc -l)
echo "   Found $PYCACHE_COUNT __pycache__ directories"

if [ "$PYCACHE_COUNT" -gt 0 ]; then
    find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
    echo "   ✅ Python cache cleaned"
else
    echo "   ℹ️  No Python cache found"
fi

# Clean .pyc files
PYC_COUNT=$(find . -name "*.pyc" -type f | wc -l)
if [ "$PYC_COUNT" -gt 0 ]; then
    find . -name "*.pyc" -type f -delete
    echo "   ✅ Removed $PYC_COUNT .pyc files"
fi

# ====================================================================
# 4. Verify Database Integrity
# ====================================================================
echo ""
echo "[4/5] Verifying database integrity..."

if docker ps | grep -q ml-assets-postgres; then
    # Check for duplicates
    DUPLICATES=$(docker exec ml-assets-postgres psql -U ml_assets_user -d ml_assets_db -t -c \
        "SELECT COUNT(*) FROM (SELECT asset_id, COUNT(*) as count FROM data_addresses GROUP BY asset_id HAVING COUNT(*) > 1) AS dups;" 2>/dev/null || echo "0")
    
    DUPLICATES=$(echo $DUPLICATES | tr -d ' ')
    
    if [ "$DUPLICATES" = "0" ]; then
        echo "   ✅ No duplicate data_addresses rows"
    else
        echo "   ⚠️  Found $DUPLICATES assets with duplicate data_addresses"
        echo "   Run: docker exec ml-assets-postgres psql -U ml_assets_user -d ml_assets_db -f /tmp/010_cleanup_database.sql"
    fi
    
    # Check total counts
    ASSETS=$(docker exec ml-assets-postgres psql -U ml_assets_user -d ml_assets_db -t -c "SELECT COUNT(*) FROM assets;" 2>/dev/null | tr -d ' ')
    DATA_ADDR=$(docker exec ml-assets-postgres psql -U ml_assets_user -d ml_assets_db -t -c "SELECT COUNT(*) FROM data_addresses;" 2>/dev/null | tr -d ' ')
    
    echo "   📊 Database stats:"
    echo "      - Assets: $ASSETS"
    echo "      - Data Addresses: $DATA_ADDR"
    echo "      - Ratio: $(awk "BEGIN {printf \"%.2f\", $DATA_ADDR/$ASSETS}")"
else
    echo "   ⚠️  Database not running (use ./deploy.sh to start)"
fi

# ====================================================================
# 5. Project Size Analysis
# ====================================================================
echo ""
echo "[5/5] Analyzing project size..."

echo "   📁 Largest directories:"
du -sh */ 2>/dev/null | sort -hr | head -5 | awk '{printf "      %s\t%s\n", $1, $2}'

echo ""
echo "   💾 Total project size:"
du -sh . | awk '{print "      "$1}'

# ====================================================================
# Summary
# ====================================================================
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ Cleanup Complete!"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "💡 Recommendations:"
echo "   • Regular cleanup: Run this script weekly"
echo "   • Monitor logs: Check *.log files before deployment"
echo "   • Database health: Verify no duplicates after updates"
echo ""
