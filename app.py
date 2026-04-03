import tkinter as tk
from tkinter import messagebox, simpledialog
import sqlite3
from datetime import datetime
import pandas as pd

# AYARLAR
ADMIN_SIFRE = "1234"
MAKS_MOLA_DK = 30

# VERİTABANI
conn = sqlite3.connect("cafe.db")
c = conn.cursor()

c.execute("""
CREATE TABLE IF NOT EXISTS personel (
    isim TEXT PRIMARY KEY,
    toplam_mola REAL DEFAULT 0
)
""")

c.execute("""
CREATE TABLE IF NOT EXISTS loglar (
    isim TEXT,
    islem TEXT,
    zaman TEXT
)
""")

conn.commit()

aktif_molalar = {}

# PERSONEL EKLE
def personel_ekle():
    isim = simpledialog.askstring("Ekle", "Personel adı:")
    if isim:
        try:
            c.execute("INSERT INTO personel (isim) VALUES (?)", (isim,))
            conn.commit()
            liste_guncelle()
        except:
            messagebox.showerror("Hata", "Zaten kayıtlı")

# PERSONEL SİL
def personel_sil():
    sifre = simpledialog.askstring("Şifre", "Admin şifre:", show="*")
    if sifre != ADMIN_SIFRE:
        messagebox.showerror("Hata", "Yanlış şifre")
        return
    
    isim = entry.get()
    c.execute("DELETE FROM personel WHERE isim=?", (isim,))
    conn.commit()
    liste_guncelle()

# MOLAYA ÇIK
def mola_baslat():
    isim = entry.get()
    if isim == "":
        return
    
    aktif_molalar[isim] = datetime.now()
    
    c.execute("INSERT INTO loglar VALUES (?, ?, ?)", (isim, "Mola Başladı", str(datetime.now())))
    conn.commit()
    
    liste_guncelle()

# MOLADAN DÖN
def mola_bitir():
    isim = entry.get()
    if isim not in aktif_molalar:
        return
    
    baslangic = aktif_molalar[isim]
    bitis = datetime.now()
    
    dakika = (bitis - baslangic).seconds / 60
    
    c.execute("UPDATE personel SET toplam_mola = toplam_mola + ? WHERE isim=?", (dakika, isim))
    conn.commit()
    
    c.execute("INSERT INTO loglar VALUES (?, ?, ?)", (isim, "Mola Bitti", str(bitis)))
    conn.commit()
    
    del aktif_molalar[isim]
    
    if dakika > MAKS_MOLA_DK:
        messagebox.showwarning("UYARI", f"{isim} tek molada limit aştı!")
    
    liste_guncelle()

# LİSTE
def liste_guncelle():
    listbox.delete(0, tk.END)
    
    for row in c.execute("SELECT * FROM personel"):
        isim, toplam = row
        listbox.insert(tk.END, f"{isim} | Toplam Mola: {round(toplam,1)} dk")

# EXCEL
def excel_aktar():
    df = pd.read_sql_query("SELECT * FROM loglar", conn)
    df.to_excel("rapor.xlsx", index=False)
    messagebox.showinfo("Tamam", "Excel oluşturuldu")

# ARAYÜZ
pencere = tk.Tk()
pencere.title("CAFE PRO MOLA TAKİP")
pencere.geometry("600x500")

tk.Label(pencere, text="Personel İsmi").pack()

entry = tk.Entry(pencere)
entry.pack()

tk.Button(pencere, text="Personel Ekle", command=personel_ekle).pack(pady=3)
tk.Button(pencere, text="Personel Sil (Admin)", command=personel_sil).pack(pady=3)

tk.Button(pencere, text="Molaya Çık", bg="orange", command=mola_baslat).pack(pady=5)
tk.Button(pencere, text="Moladan Dön", bg="green", command=mola_bitir).pack(pady=5)

tk.Button(pencere, text="Excel Rapor", command=excel_aktar).pack(pady=5)

listbox = tk.Listbox(pencere, width=70, height=20)
listbox.pack(pady=10)

liste_guncelle()

pencere.mainloop()