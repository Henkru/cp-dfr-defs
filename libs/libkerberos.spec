x64:
    remap "__imp_SpUserModeInitialize" "__imp_kerberos$SpUserModeInitialize"
    remap "__imp_SpLsaModeInitialize" "__imp_kerberos$SpLsaModeInitialize"
    remap "__imp_SpInstanceInit" "__imp_kerberos$SpInstanceInit"
    remap "__imp_SpInitialize" "__imp_kerberos$SpInitialize"
    remap "__imp_KerbMakeKdcCall" "__imp_kerberos$KerbMakeKdcCall"
    remap "__imp_KerbKdcCallBack" "__imp_kerberos$KerbKdcCallBack"
    remap "__imp_KerbIsInitialized" "__imp_kerberos$KerbIsInitialized"
    remap "__imp_KerbFree" "__imp_kerberos$KerbFree"
    remap "__imp_KerbDomainChangeCallback" "__imp_kerberos$KerbDomainChangeCallback"
    remap "__imp_KerbCreateTokenFromTicket" "__imp_kerberos$KerbCreateTokenFromTicket"
x86:
