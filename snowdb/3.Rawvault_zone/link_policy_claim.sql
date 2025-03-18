CREATE TABLE IF NOT EXISTS link_policy_claim (
    Policy_HK STRING,
    Claim_HK STRING,
    Load_DTS TIMESTAMP_NTZ,
    PRIMARY KEY (Policy_HK, Claim_HK, Load_DTS)
);