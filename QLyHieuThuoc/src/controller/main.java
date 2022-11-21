package controller;

import java.awt.Color;

import dao.ConectDatabase;
import gui.FrmDangNhap;
public class main  {
public static void main(String[] args) {
	
	ConectDatabase.getInstance().connect();
		FrmDangNhap frmDangNhap = new FrmDangNhap();
		frmDangNhap.setVisible(true);
		frmDangNhap.setLocationRelativeTo(null);
	}
}
