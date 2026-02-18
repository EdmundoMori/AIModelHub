-- ====================================================================
-- Remove Unused Columns from data_addresses Table
-- Created: 2026-02-10
-- Purpose: Drop columns that are 100% NULL across all rows
-- ====================================================================

-- Drop completely unused columns (0% usage)
ALTER TABLE data_addresses DROP COLUMN IF EXISTS folder_name;
ALTER TABLE data_addresses DROP COLUMN IF EXISTS folder;
ALTER TABLE data_addresses DROP COLUMN IF EXISTS path;

-- Verify columns removed
SELECT 
    'Remaining columns in data_addresses' as info,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_name = 'data_addresses'
ORDER BY ordinal_position;

-- Summary
SELECT '=== COLUMN CLEANUP COMPLETED ===' as status;
SELECT 'Removed: folder_name, folder, path (0% usage)' as details;
