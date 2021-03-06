table 50101 "AIR Check install process"
{
    DataPerCompany = false;

    fields
    {
        field(1; "Primary Key"; Integer)
        {
        }
        field(2; "Trigger"; Text[250])
        { }
        field(3; "Version Installing"; Text[250])
        { }
        field(4; "Company Name"; Text[250])
        { }
        field(5; "Version Installed"; Text[250])
        { }

    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    procedure InsertRecord(MessageFromTrigger: Text)
    var
    begin
        Init();
        "Primary Key" := GetNextNo();
        "Trigger" := MessageFromTrigger;
        "Company Name" := CompanyName();
        InsertVersionNo();
        Insert();
    end;

    local procedure GetNextNo(): Integer;
    begin
        if findlast then
            exit("Primary Key" + 1);
        exit(1);
    end;

    local procedure InsertVersionNo()
    var
        AppInfo: ModuleInfo;
    begin
        NavApp.GetCurrentModuleInfo(AppInfo);
        "Version Installing" := Format(AppInfo.AppVersion());
        "Version Installed" := Format(AppInfo.DataVersion());
    end;

}