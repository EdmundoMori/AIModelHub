-- Create execution_history table for tracking model executions
-- This table stores the history of model execution requests and results

CREATE TABLE IF NOT EXISTS execution_history (
    id VARCHAR(255) PRIMARY KEY,
    asset_id VARCHAR(255) NOT NULL REFERENCES assets(id) ON DELETE CASCADE,
    user_id VARCHAR(255) NOT NULL,
    connector_id VARCHAR(255) NOT NULL,
    status VARCHAR(50) NOT NULL CHECK (status IN ('pending', 'running', 'success', 'error', 'timeout')),
    input_payload JSONB NOT NULL,
    output_payload JSONB,
    error_message TEXT,
    error_code VARCHAR(100),
    http_status_code INT,
    execution_time_ms INT,
    created_at TIMESTAMP NOT NULL DEFAULT NOW(),
    started_at TIMESTAMP,
    completed_at TIMESTAMP
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_execution_history_asset_id ON execution_history(asset_id);
CREATE INDEX IF NOT EXISTS idx_execution_history_user_id ON execution_history(user_id);
CREATE INDEX IF NOT EXISTS idx_execution_history_status ON execution_history(status);
CREATE INDEX IF NOT EXISTS idx_execution_history_created_at ON execution_history(created_at DESC);

-- Comments for documentation
COMMENT ON TABLE execution_history IS 'Stores the history of model execution requests and results';
COMMENT ON COLUMN execution_history.id IS 'Unique execution identifier (UUID)';
COMMENT ON COLUMN execution_history.asset_id IS 'Reference to the executed asset';
COMMENT ON COLUMN execution_history.user_id IS 'User who requested the execution';
COMMENT ON COLUMN execution_history.connector_id IS 'Connector ID from which execution was requested';
COMMENT ON COLUMN execution_history.status IS 'Execution status: pending, running, success, error, timeout';
COMMENT ON COLUMN execution_history.input_payload IS 'Input data sent to the model';
COMMENT ON COLUMN execution_history.output_payload IS 'Output/result from the model';
COMMENT ON COLUMN execution_history.error_message IS 'Error message if execution failed';
COMMENT ON COLUMN execution_history.error_code IS 'Error code if execution failed';
COMMENT ON COLUMN execution_history.http_status_code IS 'HTTP status code from the execution request';
COMMENT ON COLUMN execution_history.execution_time_ms IS 'Total execution time in milliseconds';
COMMENT ON COLUMN execution_history.created_at IS 'Timestamp when execution was requested';
COMMENT ON COLUMN execution_history.started_at IS 'Timestamp when execution started';
COMMENT ON COLUMN execution_history.completed_at IS 'Timestamp when execution completed';

-- Grant permissions
GRANT SELECT, INSERT, UPDATE ON execution_history TO ml_assets_user;
