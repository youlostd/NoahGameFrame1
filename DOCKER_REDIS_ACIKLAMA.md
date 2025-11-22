# Docker ve Redis Kurulumu Açıklaması

## Docker Nedir?

**Docker**, uygulamaları "container" adı verilen izole ortamlarda çalıştıran bir platformdur. 

### Basit Açıklama:
- **Normal kurulum:** Programı bilgisayarınıza direkt kurarsınız (örnek: Redis'i Windows'a kurmak)
- **Docker ile kurulum:** Programı bir "kutu" (container) içinde çalıştırırsınız, bu kutu bilgisayarınızdan izole ama erişilebilirdir

### Docker'ın Avantajları:
✅ Kolay kurulum (tek komut)  
✅ Temiz kaldırma (container'ı silmek yeterli)  
✅ Sisteminizi kirletmez  
✅ Farklı versiyonları yan yana çalıştırabilirsiniz  
✅ Taşınabilir (aynı container başka bilgisayarda da çalışır)

---

## Redis Nerede Kuruldu?

### Fiziksel Konum:

Redis **Docker container'ı içinde** çalışıyor. Yani:

1. **Docker Image (Görüntü):** 
   - Redis yazılımı Docker'ın kendi depolama alanında saklanıyor
   - Konum: Docker Desktop'ın veri klasöründe
   - Windows'ta genellikle: `C:\Users\<Kullanıcı>\AppData\Local\Docker\wsl\data\`

2. **Container (Çalışan Kutu):**
   - Redis şu anda bir container içinde çalışıyor
   - Container adı: `redis-nf`
   - Container ID: `d03b538943b5`

3. **Erişim:**
   - Redis'e `127.0.0.1:6379` adresinden erişebilirsiniz
   - Docker, container içindeki 6379 portunu Windows'un 6379 portuna yönlendiriyor
   - Bu sayede projeniz Redis'e normal bir program gibi bağlanabilir

---

## Redis Detayları

### Çalışan Redis:
- **Versiyon:** Redis 7.4.7
- **İşletim Sistemi:** Linux (WSL2 içinde)
- **Port:** 6379
- **Şifre:** NoahGameFrame
- **Durum:** Çalışıyor ✅

### Redis'in Fiziksel Yeri:

```
Windows Bilgisayarınız
│
├── Docker Desktop (WSL2 üzerinde çalışıyor)
│   │
│   └── Container: redis-nf
│       │
│       └── Redis Server (Port 6379)
│           └── Veriler burada saklanıyor
│
└── Projeniz (NoahGameFrame)
    └── 127.0.0.1:6379 üzerinden Redis'e bağlanıyor
```

---

## Docker Komutları (Temel)

### Redis Container'ını Görmek:
```powershell
docker ps
```
Tüm çalışan container'ları gösterir.

### Redis Container Detayları:
```powershell
docker ps --filter "name=redis-nf"
```
Sadece Redis container'ını gösterir.

### Redis'i Durdurmak:
```powershell
docker stop redis-nf
```
Redis durur ama silinmez.

### Redis'i Başlatmak:
```powershell
docker start redis-nf
```
Durdurulmuş Redis'i tekrar başlatır.

### Redis'i Yeniden Başlatmak:
```powershell
docker restart redis-nf
```

### Redis Loglarını Görmek:
```powershell
docker logs redis-nf
```
Redis'in çıktılarını gösterir.

### Redis Container'ını Silmek:
```powershell
docker stop redis-nf
docker rm redis-nf
```
⚠️ **DİKKAT:** Bu komut Redis'i ve tüm verilerini siler!

### Redis'e Bağlanmak (Test):
```powershell
docker exec redis-nf redis-cli -a NoahGameFrame ping
```
"PONG" yanıtı alırsanız Redis çalışıyordur.

---

## Redis Verileri Nerede?

### Geçici Veriler (Varsayılan):
- Redis verileri container içinde RAM'de saklanır
- Container silinirse veriler kaybolur

### Kalıcı Veriler İçin (İsteğe Bağlı):

Eğer verilerin kalıcı olmasını istiyorsanız, Docker volume kullanabilirsiniz:

```powershell
# Mevcut container'ı durdur ve sil
docker stop redis-nf
docker rm redis-nf

# Kalıcı veri ile yeni container oluştur
docker run -d --name redis-nf -p 6379:6379 `
  -v redis-data:/data `
  --restart unless-stopped `
  redis:7-alpine redis-server --requirepass NoahGameFrame --appendonly yes
```

Bu durumda veriler `redis-data` volume'ünde saklanır ve container silinse bile veriler korunur.

---

## Docker Desktop Nedir?

**Docker Desktop**, Windows'ta Docker'ı çalıştıran bir uygulamadır.

### Docker Desktop Özellikleri:
- Windows'ta Docker container'larını çalıştırır
- WSL2 (Windows Subsystem for Linux) kullanır
- Sistem tepsisinde (tray) çalışır
- GUI (grafik arayüz) ile container'ları yönetebilirsiniz

### Docker Desktop'ı Açmak:
1. Başlat menüsünden "Docker Desktop" arayın
2. Veya sistem tepsisindeki Docker ikonuna tıklayın

### Docker Desktop'ta Redis'i Görmek:
1. Docker Desktop'ı açın
2. Sol menüden "Containers" seçin
3. `redis-nf` container'ını göreceksiniz
4. Tıklayarak detayları, logları, ayarları görebilirsiniz

---

## Projeniz Redis'e Nasıl Bağlanıyor?

Projeniz (NoahGameFrame) Redis'e şu şekilde bağlanıyor:

```
NoahGameFrame Projesi
    │
    │ (127.0.0.1:6379)
    │
    ▼
Windows Port 6379
    │
    │ (Docker port mapping)
    │
    ▼
Docker Container (redis-nf)
    │
    │ (Port 6379)
    │
    ▼
Redis Server
```

**Yani:** Projeniz normal bir program gibi `127.0.0.1:6379` adresine bağlanıyor, Docker arka planda bu bağlantıyı container içindeki Redis'e yönlendiriyor.

---

## Özet

✅ **Redis nerede?** → Docker container içinde (WSL2 üzerinde)  
✅ **Fiziksel konum?** → Docker Desktop'ın veri klasöründe  
✅ **Erişim?** → `127.0.0.1:6379` (normal program gibi)  
✅ **Şifre?** → `NoahGameFrame`  
✅ **Durum?** → Çalışıyor ✅

**Sonuç:** Redis kurulu ve çalışıyor! Projeniz Redis'e bağlanabilir. Docker sayesinde sisteminiz temiz kaldı ve Redis'i kolayca yönetebilirsiniz.

