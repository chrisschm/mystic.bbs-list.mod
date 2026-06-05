// -------------------------------------------------------------------------
// BBSSES.MPS : BBS list module for Mystic BBS software v1.12+
// -------------------------------------------------------------------------
// This program will show a BBS list like the internal Mystic View feature
//
//
// The command line option specifies the base name of the BBS list to go along
// with the same parameters of the BBS list menu commands:
//
// bbsses [bbslist name]  IE "bbsses bbslist"
// -------------------------------------------------------------------------
// Author: Christian Schmidt                                   Version: 0.1
// Telnet: home.jcs-net.de:23232
// SSH...: home.jcs-net.de:23233
// -------------------------------------------------------------------------

Uses
  CFG,
  USER

Var
  ListFile     : File;
  ListName     : String
  OutFile      : File;
  OutName      : String
  bbs_cType    : Byte
  bbs_Phone    : String
  bbs_Telnet   : String
  bbs_Name     : String
  bbs_Location : String
  bbs_Sysop    : String
  bbs_Baud     : String
  bbs_Software : String
  bbs_Deleted  : Boolean
  bbs_AddedBy  : String
  bbs_Verified : LongInt
  bbs_Extra1   : LongInt
  bbs_Extra2   : Integer
  Total        : Integer
  Temp         : String
  BBSTyp       : String
  BBSAdresse   : String

Begin
  If ParamCount <> 1 Then Begin
    WriteLn ('Invalid command line option.');
    WriteLn ('');
    WriteLn ('Usage: BBSSES [bbs list id]');
    WriteLn ('|CR|PA');
    Halt
  End

  GetThisUser

  ListName := CfgDataPath + ParamStr(1) + '.bbi';

  If Not FileExist(ListName) Then Begin
    WriteLn ('|CR|12There are no entries in the BBS list.');
    Halt;
  End;

  fAssign (ListFile, ListName, 66);
  fReset  (ListFile);

  If IoResult <> 0 Then Begin
    WriteLn('|CR|12Unable to find BBS list data.');
    Halt;
  End;

  WriteLn ('|CR|07ษ|08อ[|15 B|07BS |15N|07ame |08]อ|07อออออออออออ|08อ[|15 T|07ype |08]อ|07อ|08อ[|15 A|07ddress / |15T|07el.|08 ]อ|07อออออออ|08อ[|15 S|07oftware|08 ]อ|07ป')

  Total := 0;

  While Not fEof(ListFile) Do Begin
    fRead (ListFile, bbs_cType,     1)
    fRead (ListFile, bbs_Phone,    16)
    fRead (ListFile, bbs_Telnet,   41)
    fRead (ListFile, bbs_Name,     31)
    fRead (ListFile, bbs_Location, 26)
    fRead (ListFile, bbs_Sysop,    31)
    fRead (ListFile, bbs_Baud,      7)
    fRead (ListFile, bbs_Software, 11)
    fRead (ListFile, bbs_Deleted,   1)
    fRead (ListFile, bbs_AddedBy,  31)
    fRead (ListFile, bbs_Verified,  4)
    fRead (ListFile, bbs_Extra1,    4)
    fRead (ListFile, bbs_Extra2,    2)

    BBSTyp := '';
    BBSAdresse := '';

    If Not bbs_Deleted Then Begin
      Total := Total + 1

      if bbs_cType = 0 Then Begin
        BBSAdresse := bbs_Phone
        BBSTyp := 'Phone'
      End

      if bbs_cType = 1 Then Begin
        BBSAdresse := bbs_Telnet
        BBSTyp := 'Telnet'
      End

      if bbs_cType =2 Then Begin
        BBSAdresse := bbs_Telnet
        BBSTyp := 'Telnet'
      End

      WriteLn ('|08บ |14' + PadRT(bbs_Name, 26, ' ') + '|09' + PadRT(BBSTyp, 8, ' ') + '|10' + PadRT(BBSAdresse,31, ' ') + '|12' + PadRT(bbs_Software, 11, ' ') + '|08บ')
    End
  End;

  WriteLn ('|07ศอ|08อออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออ|07อผ|16|CR');
  fClose (ListFile)

End;
