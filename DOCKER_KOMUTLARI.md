# Docker Komutları Kullanım Kılavuzu

## Bu Komutları Nereye Yazacaksınız?

Bu komutlar **PowerShell** veya **Command Prompt** (CMD) terminalinde çalıştırılır.

---

## Terminal Açma Yöntemleri

### Yöntem 1: PowerShell (Önerilen)
1. **Windows tuşu + X** tuşlarına basın
2. **"Windows PowerShell"** veya **"Terminal"** seçin
3. Veya **Başlat menüsünde** "PowerShell" yazıp açın

### Yöntem 2: Command Prompt (CMD)
1. **Windows tuşu + R** tuşlarına basın
2. **"cmd"** yazın ve Enter'a basın
3. Veya **Başlat menüsünde** "cmd" yazıp açın

### Yöntem 3: Visual Studio Code Terminal
1. Visual Studio Code'u açın
2. **Ctrl + `** (backtick tuşu) ile terminali açın
3. Veya **Terminal > New Terminal** menüsünden açın

### Yöntem 4: Cursor Terminal
1. Cursor'da **Ctrl + `** tuşlarına basın
2. Veya **Terminal > New Terminal** menüsünden açın

---

## Komutları Nasıl Kullanacaksınız?

### Adım 1: Terminali Açın
Yukarıdaki yöntemlerden birini kullanarak terminali açın.

### Adım 2: Komutu Yazın ve Enter'a Basın
Terminalde komutu yazın ve **Enter** tuşuna basın.

**Örnek:**
```
docker ps --filter "name=mysql-nf"
```

### Adım 3: Sonucu Görün
Komut çalıştırıldıktan sonra sonuç ekranda görünecektir.

---

## MySQL Komutları (Detaylı)

### 1. MySQL Durumunu Görmek
```powershell
docker ps --filter "name=mysql-nf"
```
**Ne yapar:** MySQL container'ının çalışıp çalışmadığını gösterir.

**Örnek çıktı:**
```
NAMES      STATUS          PORTS
mysql-nf   Up 5 minutes    0.0.0.0:3306->3306/tcp
```

---

### 2. MySQL'i Durdurmak
```powershell
docker stop mysql-nf
```
**Ne yapar:** MySQL container'ını durdurur (ama silmez).

**Kullanım:** MySQL'i geçici olarak durdurmak istediğinizde.

---

### 3. MySQL'i Başlatmak
```powershell
docker start mysql-nf
```
**Ne yapar:** Durdurulmuş MySQL container'ını tekrar başlatır.

**Kullanım:** MySQL'i tekrar başlatmak istediğinizde.

---

### 4. MySQL Loglarını Görmek
```powershell
docker logs mysql-nf
```
**Ne yapar:** MySQL'in çıktılarını (loglarını) gösterir.

**Kullanım:** MySQL'de bir sorun olduğunda hata mesajlarını görmek için.

**Son logları görmek için:**
```powershell
docker logs mysql-nf --tail 50
```
(Son 50 satırı gösterir)

---

### 5. MySQL'e Bağlanmak (Test)
```powershell
docker exec -it mysql-nf mysql -uroot -proot123 app_test
```
**Ne yapar:** MySQL veritabanına bağlanır ve SQL komutları çalıştırabilirsiniz.

**Kullanım:**
- Veritabanını kontrol etmek için
- SQL sorguları çalıştırmak için
- Tabloları görmek için

**Çıktıktan sonra:**
- SQL komutları yazabilirsiniz
- Çıkmak için `exit` yazıp Enter'a basın

**Örnek SQL komutları:**
```sql
SHOW TABLES;           -- Tabloları göster
SELECT * FROM AccountInfo;  -- AccountInfo tablosundaki verileri göster
exit                   -- Çıkış yap
```

---

## Redis Komutları (Bonus)

### Redis Durumunu Görmek
```powershell
docker ps --filter "name=redis-nf"
```

### Redis'i Durdurmak
```powershell
docker stop redis-nf
```

### Redis'i Başlatmak
```powershell
docker start redis-nf
```

### Redis Loglarını Görmek
```powershell
docker logs redis-nf
```

### Redis'e Bağlanmak (Test)
```powershell
docker exec -it redis-nf redis-cli -a NoahGameFrame
```

---

## Pratik Örnekler

### Senaryo 1: MySQL Çalışıyor mu Kontrol Etmek
```powershell
# Terminali açın ve şunu yazın:
docker ps --filter "name=mysql-nf"
```

### Senaryo 2: MySQL'i Yeniden Başlatmak
```powershell
# Terminali açın ve şunu yazın:
docker stop mysql-nf
docker start mysql-nf
```

### Senaryo 3: MySQL'de Sorun Var, Logları Görmek İstiyorum
```powershell
# Terminali açın ve şunu yazın:
docker logs mysql-nf --tail 100
```

### Senaryo 4: MySQL'deki Tabloları Görmek
```powershell
# Terminali açın ve şunu yazın:
docker exec -it mysql-nf mysql -uroot -proot123 app_test
# Sonra SQL komutunu yazın:
SHOW TABLES;
# Çıkmak için:
exit
```

---

## Hızlı Referans

| Komut | Ne İşe Yarar |
|-------|--------------|
| `docker ps` | Tüm çalışan container'ları gösterir |
| `docker ps -a` | Tüm container'ları gösterir (durmuş olanlar dahil) |
| `docker stop mysql-nf` | MySQL'i durdurur |
| `docker start mysql-nf` | MySQL'i başlatır |
| `docker restart mysql-nf` | MySQL'i yeniden başlatır |
| `docker logs mysql-nf` | MySQL loglarını gösterir |
| `docker rm mysql-nf` | MySQL container'ını siler (⚠️ DİKKAT: Veriler kaybolur!) |

---

## İpuçları

1. **Komutları kopyala-yapıştır yapabilirsiniz:**
   - Komutu seçin (fare ile)
   - **Ctrl + C** ile kopyalayın
   - Terminale **Ctrl + V** ile yapıştırın
   - **Enter** tuşuna basın

2. **Komut geçmişi:**
   - Terminalde **Yukarı ok (↑)** tuşuna basarak önceki komutları görebilirsiniz

3. **Otomatik tamamlama:**
   - **Tab** tuşuna basarak komutları otomatik tamamlayabilirsiniz

4. **Hata alırsanız:**
   - Komutu tekrar kontrol edin
   - Container adının doğru olduğundan emin olun (`mysql-nf`, `redis-nf`)

---

## Özet

✅ **Nereye yazacaksınız?** → PowerShell veya Command Prompt terminaline  
✅ **Nasıl açacaksınız?** → Windows tuşu + X → PowerShell  
✅ **Nasıl kullanacaksınız?** → Komutu yazın → Enter'a basın  
✅ **Kopyala-yapıştır yapabilir misiniz?** → Evet!  

**Kolay gelsin!** 🚀

