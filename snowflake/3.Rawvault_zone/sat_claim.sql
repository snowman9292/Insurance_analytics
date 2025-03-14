
CREATE TABLE sat_claim (
    Claim_HK STRING,
    Claim_Date DATE,
    Claim_Amount NUMBER(12,2),
    Claim_Status STRING,
    Hash_Diff STRING,
    Load_DTS TIMESTAMP_NTZ,
    PRIMARY KEY (Claim_HK, Load_DTS)
);
