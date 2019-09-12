--
-- Create table schema
--
CREATE TABLE tenants6 (
    tenant_id serial PRIMARY KEY,
    tenant_name VARCHAR (50) UNIQUE NOT NULL,
    subscription_id VARCHAR (50) NOT NULL
);

--
-- Populate sample data
--
INSERT INTO tenants6 (tenant_name, subscription_id) VALUES
('Trey Research', '35125272-0253-4703-a712-e00bb6ace803'),
('Contoso', '961c1a03-7f8d-478c-ad3e-189b7c6044e6'),
('Fabrikam', '0007ef33-f284-4dfa-b27c-43ec7034f2b9');

--
-- List sample data
--
SELECT tenant_name, subscription_id FROM tenants6;
