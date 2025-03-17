
CREATE TABLE bridge_active_claims (
    Policy_HK STRING NOT NULL,
    Claim_HK STRING NOT NULL,
    Claim_Amount NUMBER(18,2),
    Claim_Status STRING,
    Load_DTS TIMESTAMP NOT NULL
);