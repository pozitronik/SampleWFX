library SampleWFX;

uses
	System.SysUtils, System.Classes, PLUGIN_TYPES, ANSIFunctions in 'ANSIFunctions.pas', Windows;

{$IFDEF WIN64}
{$E wfx64}
{$ENDIF}
{$IFDEF WIN32}
{$E wfx}
{$ENDIF}
{$R *.res}

const
{$IFDEF WIN64}
	PlatformDllPath = 'x64';
{$ENDIF}
{$IFDEF WIN32}
	PlatformDllPath = 'x32';
{$ENDIF}

var

	{Callback data}
	PluginNum: integer;
	MyProgressProc: TProgressProcW;
	MyLogProc: TLogProcW;
	MyRequestProc: TRequestProcW;

function FsGetBackgroundFlags: integer; stdcall;
begin
	Result := BG_DOWNLOAD + BG_UPLOAD;
end;

function FsInit(PluginNr: integer; pProgressProc: TProgressProc; pLogProc: TLogProc; pRequestProc: TRequestProc): integer; stdcall;
Begin
	Result := 0;
end;

{GLORIOUS UNICODE MASTER RACE}

function FsInitW(PluginNr: integer; pProgressProc: TProgressProcW; pLogProc: TLogProcW; pRequestProc: TRequestProcW): integer; stdcall; //Вход в плагин.
Begin
	PluginNum := PluginNr;
	MyProgressProc := pProgressProc;
	MyLogProc := pLogProc;
	MyRequestProc := pRequestProc;
	Result := 0;
end;

procedure FsStatusInfoW(RemoteDir: pWideChar; InfoStartEnd, InfoOperation: integer); stdcall; //Начало и конец операций FS
begin
	if (InfoStartEnd = FS_STATUS_START) then
	begin
		case InfoOperation of
			FS_STATUS_OP_LIST:
				begin

				end;
			FS_STATUS_OP_GET_SINGLE:
				begin
				end;
			FS_STATUS_OP_GET_MULTI:
				begin
				end;
			FS_STATUS_OP_PUT_SINGLE:
				begin
				end;
			FS_STATUS_OP_PUT_MULTI:
				begin
				end;
			FS_STATUS_OP_RENMOV_SINGLE:
				begin
				end;
			FS_STATUS_OP_RENMOV_MULTI:
				begin
				end;
			FS_STATUS_OP_DELETE:
				begin
				end;
			FS_STATUS_OP_ATTRIB:
				begin
				end;
			FS_STATUS_OP_MKDIR:
				begin
				end;
			FS_STATUS_OP_EXEC:
				begin
				end;
			FS_STATUS_OP_CALCSIZE:
				begin
				end;
			FS_STATUS_OP_SEARCH:
				begin
				end;
			FS_STATUS_OP_SEARCH_TEXT:
				begin
				end;
			FS_STATUS_OP_SYNC_SEARCH:
				begin
				end;
			FS_STATUS_OP_SYNC_GET:
				begin
				end;
			FS_STATUS_OP_SYNC_PUT:
				begin
				end;
			FS_STATUS_OP_SYNC_DELETE:
				begin
				end;
			FS_STATUS_OP_GET_MULTI_THREAD:
				begin
				end;
			FS_STATUS_OP_PUT_MULTI_THREAD:
				begin
				end;
		end;
		exit;
	end;
	if (InfoStartEnd = FS_STATUS_END) then
	begin
		case InfoOperation of
			FS_STATUS_OP_LIST:
				begin
				end;
			FS_STATUS_OP_GET_SINGLE:
				begin
				end;
			FS_STATUS_OP_GET_MULTI:
				begin
				end;
			FS_STATUS_OP_PUT_SINGLE:
				begin
				end;
			FS_STATUS_OP_PUT_MULTI:
				begin
				end;
			FS_STATUS_OP_RENMOV_SINGLE:
				begin
				end;
			FS_STATUS_OP_RENMOV_MULTI:
				begin
				end;
			FS_STATUS_OP_DELETE:
				begin
				end;
			FS_STATUS_OP_ATTRIB:
				begin
				end;
			FS_STATUS_OP_MKDIR:
				begin
				end;
			FS_STATUS_OP_EXEC:
				begin
				end;
			FS_STATUS_OP_CALCSIZE:
				begin
				end;
			FS_STATUS_OP_SEARCH:
				begin
				end;
			FS_STATUS_OP_SEARCH_TEXT:
				begin
				end;
			FS_STATUS_OP_SYNC_SEARCH:
				begin
				end;
			FS_STATUS_OP_SYNC_GET:
				begin
				end;
			FS_STATUS_OP_SYNC_PUT:
				begin
				end;
			FS_STATUS_OP_SYNC_DELETE:
				begin
				end;
			FS_STATUS_OP_GET_MULTI_THREAD:
				begin
				end;
			FS_STATUS_OP_PUT_MULTI_THREAD:
				begin
				end;
		end;
		exit;
	end;
end;

function FsFindFirstW(path: pWideChar; var FindData: tWIN32FINDDATAW): THandle; stdcall;

begin
	FindData.nFileSizeLow := $FFFF;
	FindData.cFileName := 'random.txt';
	Result := 0;
	SetLastError(ERROR_NO_MORE_FILES);
end;

function FsFindNextW(Hdl: THandle; var FindData: tWIN32FINDDATAW): Bool; stdcall;
begin
	Result := false;
end;

function FsFindClose(Hdl: THandle): integer; stdcall;
Begin

end;

function FsGetFileW(RemoteName, LocalName: pWideChar; CopyFlags: integer; RemoteInfo: pRemoteInfo): integer; stdcall; //Копирование файла из файловой системы плагина
var
	I, y, r: integer;
	abracadabra: WideString;
	FileStream: TFileStream;
begin
	MyProgressProc(PluginNum, RemoteName, LocalName, 0);
	FileStream := TFileStream.Create(LocalName, fmCreate);
	for I := 1 to 100 do
	begin
		abracadabra := '';
		for y := 0 to $5FFF do abracadabra := abracadabra + Random(I).ToString;

		FileStream.Write(abracadabra, Length(abracadabra));
		r := MyProgressProc(PluginNum, RemoteName, LocalName, I);
		if r <> 0 then
		begin
			MessageBoxW(0, 'booya', pWideChar(r.ToString), mb_ok);
		end;
		//Sleep(100);
	end;
	FlushFileBuffers(FileStream.Handle);
	FileStream.free;
	Result := FS_FILE_OK;

end;

function FsDisconnectW(DisconnectRoot: pWideChar): Bool; stdcall;
begin

	Result := true;
end;

procedure InitPluginData;
begin
	IsMultiThread := true;
end;

procedure FreePluginData;
begin

end;

procedure DllInit(Code: integer);
begin
	case Code of
		DLL_PROCESS_ATTACH:
			begin
				InitPluginData;
			end;
		DLL_PROCESS_DETACH:
			begin
				FreePluginData;
			end;
		DLL_THREAD_ATTACH:
			begin

			end;
		DLL_THREAD_DETACH:
			begin

			end;
	end; //case
end;

exports FsGetDefRootName, FsInit, FsInitW, FsFindFirst, FsFindFirstW, FsFindNext, FsFindNextW, FsFindClose, FsGetFile, FsGetFileW, FsDisconnect, FsDisconnectW, FsStatusInfo, FsStatusInfoW, FsPutFile, FsDeleteFile, FsGetBackgroundFlags, FsContentGetSupportedField, FsContentGetValue;

begin
	//ReportMemoryLeaksOnShutdown := true;
	DllProc := @DllInit;
	DllInit(DLL_PROCESS_ATTACH);

end.
