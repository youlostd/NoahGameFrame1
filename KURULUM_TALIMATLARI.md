# NoahGameFrame Kurulum Talimatları

## Gerekli Servisler

Projeyi çalıştırmak için aşağıdaki servislerin kurulu ve çalışır durumda olması gerekiyor:

### 1. Redis Server

#### Windows için Redis Kurulumu:

**Seçenek A: Memurai (Önerilen - Windows için)**
1. Memurai'yi indirin: https://www.memurai.com/get-memurai
2. Kurulumu tamamlayın
3. Memurai servisini başlatın (Windows Services'ten veya Start Menu'den)

**Seçenek B: WSL2 ile Redis**
1. WSL2'yi kurun (Windows Subsystem for Linux)
2. WSL2 içinde Redis kurun:
   ```bash
   sudo apt-get update
   sudo apt-get install redis-server
   sudo service redis-server start
   ```

**Seçenek C: Docker ile Redis**
```powershell
docker run -d -p 6379:6379 --name redis redis:latest redis-server --requirepass NoahGameFrame
```

#### Redis Yapılandırması:

Proje şu ayarları kullanıyor:
- **IP:** `127.0.0.1`
- **Port:** `6379`
- **Şifre:** `NoahGameFrame`

Redis'i şifre ile çalıştırmak için:
1. Redis config dosyasını düzenleyin (genellikle `redis.conf`)
2. Şu satırı ekleyin veya düzenleyin:
   ```
   requirepass NoahGameFrame
   ```
3. Redis'i yeniden başlatın

**Redis Test:**
```powershell
# Redis'in çalışıp çalışmadığını test edin
redis-cli -h 127.0.0.1 -p 6379 -a NoahGameFrame ping
# Yanıt: PONG olmalı
```

---

### 2. MySQL Server

#### Windows için MySQL Kurulumu:

**Seçenek A: MySQL Community Server (Önerilen)**
1. MySQL Community Server'ı indirin: https://dev.mysql.com/downloads/mysql/
2. MySQL Installer'ı çalıştırın
3. Kurulum sırasında:
   - Root şifresi belirleyin (not edin!)
   - Port: `3306` (varsayılan)
   - MySQL Server servisini otomatik başlatmayı seçin

**Seçenek B: XAMPP (Kolay Kurulum)**
1. XAMPP'ı indirin: https://www.apachefriends.org/
2. Kurulumu tamamlayın
3. XAMPP Control Panel'den MySQL'i başlatın

**Seçenek C: Docker ile MySQL**
```powershell
docker run -d -p 3306:3306 --name mysql -e MYSQL_ROOT_PASSWORD=root123 mysql:8.0
```

#### MySQL Veritabanı Kurulumu:

1. MySQL'e bağlanın:
   ```powershell
   mysql -u root -p
   ```

2. Veritabanını oluşturun:
   ```sql
   CREATE DATABASE app_test CHARACTER SET utf8 COLLATE utf8_general_ci;
   USE app_test;
   ```

3. SQL dosyalarını import edin:
   ```powershell
   # Proje klasöründe
   mysql -u root -p app_test < _Out\NFDataCfg\mysql\app_test.sql
   mysql -u root -p app_test < _Out\NFDataCfg\mysql\NFClass.sql
   mysql -u root -p app_test < _Out\NFDataCfg\mysql\NFrame.sql
   ```

**MySQL Test:**
```powershell
mysql -u root -p -e "SHOW DATABASES;"
# app_test veritabanını görmelisiniz
```

---

### 3. Servislerin Çalıştığını Kontrol Etme

#### Redis Kontrolü:
```powershell
# PowerShell'de
Test-NetConnection -ComputerName 127.0.0.1 -Port 6379
```

#### MySQL Kontrolü:
```powershell
# PowerShell'de
Test-NetConnection -ComputerName 127.0.0.1 -Port 3306
```

---

### 4. Projeyi Çalıştırma

Servisler hazır olduktan sonra:

**Debug Modu:**
```powershell
cd C:\Users\ismail\Desktop\NoahGameFrame1\_Out
.\rund.bat
```

**Release Modu:**
```powershell
cd C:\Users\ismail\Desktop\NoahGameFrame1\_Out
.\runr.bat
```

Bu script'ler şu sunucuları sırayla başlatır:
1. MasterServer (Port: 13001)
2. WorldServer (Port: 17001)
3. LoginServer (Port: 14001)
4. DBServer (Port: 18001)
5. GameServer (Port: 16001)
6. ProxyServer (Port: 15001)

---

### 5. Sorun Giderme

**Redis bağlantı hatası:**
- Redis servisinin çalıştığından emin olun
- Şifrenin `NoahGameFrame` olduğunu kontrol edin
- Firewall'ın 6379 portunu engellemediğinden emin olun

**MySQL bağlantı hatası:**
- MySQL servisinin çalıştığından emin olun
- Veritabanının oluşturulduğunu kontrol edin
- SQL dosyalarının import edildiğini kontrol edin
- Firewall'ın 3306 portunu engellemediğinden emin olun

**Log dosyaları:**
- Loglar `_Out\logs\` klasöründe bulunur
- Her sunucu için ayrı log dosyası oluşturulur

---

### Hızlı Başlangıç (Özet)

1. **Redis Kur:**
   - Memurai veya Docker ile Redis kur
   - Şifre: `NoahGameFrame`

2. **MySQL Kur:**
   - MySQL Community Server kur
   - `app_test` veritabanını oluştur
   - SQL dosyalarını import et

3. **Servisleri Başlat:**
   - Redis servisini başlat
   - MySQL servisini başlat

4. **Projeyi Çalıştır:**
   ```powershell
   cd C:\Users\ismail\Desktop\NoahGameFrame1\_Out
   .\rund.bat
   ```

---

## Notlar

- Redis şifresi config dosyasında: `_Out\NFDataCfg\Ini\Side\NoSqlServer.xml`
- MySQL ayarları kod içinde tanımlı (muhtemelen `NFDBLogicPlugin` içinde)
- Tüm sunucular `127.0.0.1` (localhost) üzerinde çalışır
- Portlar `Server.xml` dosyasında tanımlı

