unit uBitmap;

interface

uses
  system.classes, system.types, vcl.imaging.jpeg, vcl.imaging.pngimage,
  vcl.graphics, idhttp, system.sysutils;

type
  TBmpHlp = class helper for TBitmap
  public
    procedure loadImgFromUrl(url:string);
  end;
implementation

{ TBmpHlp }

procedure TBmpHlp.loadImgFromUrl(url: string);
var
  nhc: TIdHttp;
  strm : TMemoryStream;
  jpg :TJPEGImage;
  ext: string;
  png: TPngImage;
begin
  ext := url.Substring(url.Length-3,3);
  nhc:=tidhttp.Create(nil);
  strm:=TMemoryStream.Create;

  try
      nhc.Get(url,strm);
      if strm.Size >0 then
      begin
        strm.Position:=0;

          if ext='jpg' then
            begin
            jpg := tjpegimage.create;
            try
              jpg.loadFromStream(strm);
              assign(jpg);
            finally
              jpg.Free;
            end;
            end
          else if ext='png' then
            begin
              png := TPngImage.Create;
            try
              png.LoadFromStream(strm);
              assign(png);
            finally
              png.Free;
            end;

            end;
      end;
  finally
    nhc.Free;
    strm.Free;
  end;
end;

end.
