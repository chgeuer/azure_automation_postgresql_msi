CREATE TABLE tenants (
    tenant_id serial PRIMARY KEY,
    tenant_name VARCHAR (50) UNIQUE NOT NULL,
    subscription_id VARCHAR (50) NOT NULL
);