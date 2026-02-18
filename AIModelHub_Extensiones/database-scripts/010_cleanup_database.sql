-- ====================================================================
-- Database Cleanup Script - Remove Duplicates and Redundant Columns
-- Created: 2026-02-10
-- Purpose: Clean up duplicate rows and redundant foreign keys
-- ====================================================================

-- ====================================================================
-- PART 1: Remove Duplicate data_addresses Rows
-- ====================================================================

-- Step 1: Create temporary table with unique data_addresses (keep the one with lowest ID)
CREATE TEMP TABLE unique_data_addresses AS
SELECT DISTINCT ON (asset_id) *
FROM data_addresses
ORDER BY asset_id, id ASC;

-- Step 2: Show what will be deleted (for logging)
SELECT 
    'Duplicate data_addresses to delete' as info,
    COUNT(*) as count
FROM data_addresses da
WHERE NOT EXISTS (
    SELECT 1 FROM unique_data_addresses uda
    WHERE uda.id = da.id
);

-- Step 3: Delete duplicate rows
DELETE FROM data_addresses
WHERE id NOT IN (SELECT id FROM unique_data_addresses);

-- Step 4: Verify results
SELECT 
    COUNT(*) as total_rows, 
    COUNT(DISTINCT asset_id) as unique_assets,
    COUNT(*) - COUNT(DISTINCT asset_id) as remaining_duplicates
FROM data_addresses;

-- ====================================================================
-- PART 2: Remove Redundant Foreign Key Constraint from ml_metadata
-- ====================================================================

-- Drop the duplicate foreign key constraint (ml_metadata_asset_id_fkey1)
ALTER TABLE ml_metadata DROP CONSTRAINT IF EXISTS ml_metadata_asset_id_fkey1;

-- Verify only one foreign key remains
SELECT 
    conname as constraint_name
FROM pg_constraint
WHERE conrelid = 'ml_metadata'::regclass
    AND contype = 'f';

-- ====================================================================
-- PART 3: Identify Unused Columns in data_addresses
-- ====================================================================

-- Check which columns are mostly NULL (candidates for removal)
SELECT 
    'folder_name usage' as column_analysis,
    COUNT(*) as total_rows,
    COUNT(folder_name) as non_null_values,
    ROUND(100.0 * COUNT(folder_name) / COUNT(*), 2) as percentage_used
FROM data_addresses
UNION ALL
SELECT 
    'folder usage',
    COUNT(*),
    COUNT(folder),
    ROUND(100.0 * COUNT(folder) / COUNT(*), 2)
FROM data_addresses
UNION ALL
SELECT 
    'path usage',
    COUNT(*),
    COUNT(path),
    ROUND(100.0 * COUNT(path) / COUNT(*), 2)
FROM data_addresses
UNION ALL
SELECT 
    'base_url usage',
    COUNT(*),
    COUNT(base_url),
    ROUND(100.0 * COUNT(base_url) / COUNT(*), 2)
FROM data_addresses
UNION ALL
SELECT 
    'endpoint_override usage',
    COUNT(*),
    COUNT(endpoint_override),
    ROUND(100.0 * COUNT(endpoint_override) / COUNT(*), 2)
FROM data_addresses
UNION ALL
SELECT 
    'execution_endpoint usage',
    COUNT(*),
    COUNT(execution_endpoint),
    ROUND(100.0 * COUNT(execution_endpoint) / COUNT(*), 2)
FROM data_addresses;

-- ====================================================================
-- PART 4: Summary Report
-- ====================================================================

SELECT '=== CLEANUP SUMMARY ===' as report;

SELECT 
    'Assets Table' as table_name,
    COUNT(*) as total_records
FROM assets
UNION ALL
SELECT 
    'Data Addresses',
    COUNT(*)
FROM data_addresses
UNION ALL
SELECT 
    'ML Metadata',
    COUNT(*)
FROM ml_metadata
UNION ALL
SELECT 
    'Execution History',
    COUNT(*)
FROM execution_history;

-- Final verification: Check for any remaining duplicates
SELECT 
    asset_id,
    COUNT(*) as occurrences
FROM data_addresses
GROUP BY asset_id
HAVING COUNT(*) > 1;

SELECT '=== CLEANUP COMPLETED ===' as status;
