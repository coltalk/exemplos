unit uFMXUsandoGenerics;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants, System.Generics.collections,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, Data.Bind.ObjectScope, Data.Bind.Components,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Grid, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, FMX.Bind.Grid, System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.Grid, FMX.StdCtrls;

type

  TBase = class
    Nome: string;
  end;

  TForm41 = class(TForm)
    StringGrid1: TStringGrid;
    AdapterBindSource1: TAdapterBindSource;
    DataGeneratorAdapter1: TDataGeneratorAdapter;
    Button1: TButton;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceAdapterBindSource1: TLinkGridToDataSource;
    Button2: TButton;
    procedure AdapterBindSource1CreateAdapter(Sender: TObject;
      var ABindSourceAdapter: TBindSourceAdapter);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FLista: TObjectList<TBase>;
    procedure Reflesh;
  public
    { Public declarations }
  end;

var
  Form41: TForm41;

implementation

{$R *.fmx}

procedure TForm41.AdapterBindSource1CreateAdapter(Sender: TObject;
  var ABindSourceAdapter: TBindSourceAdapter);
begin
  // cria a base para mostrar o objeto no StringGrid
  FLista := TObjectList<TBase>.create;
  ABindSourceAdapter := TListBindSourceAdapter<TBase>.create(self, FLista);
end;

procedure TForm41.Button1Click(Sender: TObject);
var
  base: TBase;
begin
  StringGrid1.BeginUpdate;
  try
    base := TBase.create;
    base.Nome := DateTimeToStr(now);
    FLista.Add(base);
  finally
    StringGrid1.EndUpdate;
  end;

  Reflesh;

end;

procedure TForm41.Reflesh;
begin
  AdapterBindSource1.InternalAdapter.Refresh;
end;

procedure TForm41.Button2Click(Sender: TObject);
begin
  StringGrid1.BeginUpdate;
  try
    if (StringGrid1.Selected >= 0) and (StringGrid1.Selected < FLista.Count)
    then
      FLista.Delete(StringGrid1.Selected);
    Reflesh;
  finally
    StringGrid1.EndUpdate;
  end;
end;

end.
