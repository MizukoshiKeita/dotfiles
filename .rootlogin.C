{
	gROOT->SetStyle("Plain");
	gStyle->SetTitleBorderSize(0);
	gStyle->SetFrameFillColor(0);
	gStyle->SetCanvasColor(0);
	gStyle->SetPadBorderSize(0);

	gStyle->SetTitleAlign(22);
	gStyle->SetTitleX(0.5);
	gStyle->SetTitleY(0.95);

	gStyle->SetPadTickX(1);
	gStyle->SetPadTickY(1);

	Int_t fontid = 132;
	gStyle->SetStatFont(fontid);
	gStyle->SetLabelFont(fontid,"XYZ");
	gStyle->SetLabelFont(fontid,"");
	gStyle->SetTitleFont(fontid,"XYZ");
	gStyle->SetTitleFont(fontid,"");
	gStyle->SetTitleOffset(1.2,"XYZ");
	gStyle->SetTextFont(fontid);
	gStyle->SetFuncWidth(2);
	gStyle->SetLegendBorderSize(0);

	gStyle->SetPalette(1);
}
