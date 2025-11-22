# Client (İstemci) Kurulum Rehberi

## Client Nedir?

**Client (İstemci)**, oyuncuların oyunu oynadığı uygulamadır. Sunucuya bağlanır, oyun verilerini alır ve oyuncu arayüzünü gösterir.

---

## Client Seçenekleri

NoahGameFrame için birkaç client seçeneği var:

### 1. Unity Client (Önerilen) 🎮
- **SDK:** NFUnitySDK
- **GitHub:** https://github.com/ketoo/NFUnitySDK
- **Dil:** C#
- **Platform:** Windows, Mac, Linux, iOS, Android
- **Özellikler:**
  - Unity Editor ile geliştirme
  - Görsel arayüz (UI)
  - 3D/2D oyun desteği
  - Çok platformlu

### 2. WebSocket Client (Web) 🌐
- **Dosya:** `_Out/websocket_chat_demo.htm`
- **Dil:** JavaScript
- **Platform:** Web tarayıcıları
- **Özellikler:**
  - Hızlı test için ideal
  - HTML/JavaScript ile basit client
  - WebSocket bağlantısı

### 3. C++ Client (Gelişmiş) 💻
- **Dil:** C++
- **Platform:** Windows, Linux
- **Özellikler:**
  - Yüksek performans
  - Sunucu ile aynı teknoloji
  - Daha fazla kontrol

---

## Unity Client Kurulumu (Önerilen)

### Adım 1: Unity Hub ve Unity Editor Kurulumu

1. **Unity Hub'ı indirin:**
   - https://unity.com/download
   - Unity Hub'ı kurun

2. **Unity Editor'ü kurun:**
   - Unity Hub'ı açın
   - "Installs" sekmesine gidin
   - "Install Editor" butonuna tıklayın
   - **Unity 2020.3 LTS** veya daha yeni bir versiyon seçin (önerilen)

### Adım 2: NFUnitySDK İndirme

1. **GitHub'dan indirin:**
   ```powershell
   git clone https://github.com/ketoo/NFUnitySDK.git
   ```
   
   Veya GitHub'dan ZIP olarak indirin:
   - https://github.com/ketoo/NFUnitySDK
   - "Code" → "Download ZIP"

2. **Klasöre çıkarın:**
   - İndirdiğiniz dosyayı bir klasöre çıkarın
   - Örnek: `C:\Projects\NFUnitySDK`

### Adım 3: Unity Projesini Açma

1. **Unity Hub'ı açın**
2. **"Open"** butonuna tıklayın
3. **NFUnitySDK** klasörünü seçin
4. Unity Editor açılacak

### Adım 4: Sunucu Bağlantı Ayarları

Unity client'ın sunucuya bağlanması için ayarları yapmanız gerekiyor:

1. **Unity Editor'de:**
   - `Assets` → `Scripts` → `Network` klasörünü bulun
   - Bağlantı ayarları dosyasını bulun (genellikle `NetworkManager.cs` veya benzeri)

2. **Sunucu IP ve Port ayarları:**
   ```csharp
   // Örnek ayarlar
   string serverIP = "127.0.0.1";  // Localhost
   int serverPort = 15001;         // ProxyServer portu
   ```

3. **Sunucu portları:**
   - **ProxyServer:** 15001 (oyuncular buraya bağlanır)
   - **LoginServer:** 14001
   - **GameServer:** 16001
   - **WorldServer:** 17001

### Adım 5: Protobuf Dosyalarını Kopyalama

Unity client'ın sunucu ile iletişim kurabilmesi için protobuf dosyalarına ihtiyacı var:

1. **Protobuf dosyalarını kopyalayın:**
   ```powershell
   # Proje klasöründe
   Copy-Item "_Out\NFDataCfg\client\proto\*.cs" "C:\Projects\NFUnitySDK\Assets\Scripts\Protocol\" -Force
   ```

2. **Veya manuel olarak:**
   - `_Out\NFDataCfg\client\proto\` klasöründeki `.cs` dosyalarını
   - Unity projesinin `Assets\Scripts\Protocol\` klasörüne kopyalayın

### Adım 6: Unity Projesini Derleme

1. **Unity Editor'de:**
   - `File` → `Build Settings`
   - Platform seçin (Windows, Mac, Linux, vs.)
   - `Build` butonuna tıklayın

2. **Veya Play butonu ile test:**
   - Unity Editor'de `Play` butonuna basın
   - Client çalışacak ve sunucuya bağlanmaya çalışacak

---

## WebSocket Client (Hızlı Test)

WebSocket client ile hızlıca test yapabilirsiniz:

### Adım 1: HTML Dosyasını Açma

1. **Dosyayı bulun:**
   - `_Out\websocket_chat_demo.htm`

2. **Tarayıcıda açın:**
   - Dosyaya çift tıklayın
   - Veya sağ tık → "Open with" → Tarayıcı seçin

### Adım 2: Sunucuya Bağlanma

1. **ProxyServer portunu girin:**
   - WebSocket port: `ws://127.0.0.1:25001` (ProxyServer WebSocket portu)
   - Normal port: `ws://127.0.0.1:15001`

2. **"Connect" butonuna tıklayın**

3. **Mesaj göndermeyi deneyin**

### Sunucu Portları (WebSocket)

- **ProxyServer WebSocket:** 25001
- **ProxyServer Normal:** 15001

---

## C++ Client (Gelişmiş)

C++ client geliştirmek için:

1. **Client kodunu yazın:**
   - `NFComm/NFNetPlugin/NFNetClientModule.h` ve `.cpp` dosyalarını inceleyin
   - Client örneği için Tutorial klasörüne bakın

2. **Protobuf dosyalarını kullanın:**
   - `_Out\NFDataCfg\client\proto\` klasöründeki `.h` ve `.cc` dosyalarını kullanın

3. **Sunucuya bağlanın:**
   ```cpp
   // Örnek bağlantı
   NFNetClientModule* pClient = new NFNetClientModule();
   pClient->AddServer(ConnectData{
       .ip = "127.0.0.1",
       .nPort = 15001,
       .eServerType = NF_ST_PROXY
   });
   ```

---

## Sunucu Bağlantı Bilgileri

### Sunucu Portları

| Sunucu | Port | WebSocket Port | Açıklama |
|--------|------|----------------|----------|
| **ProxyServer** | 15001 | 25001 | Oyuncular buraya bağlanır |
| LoginServer | 14001 | - | Giriş işlemleri |
| GameServer | 16001 | - | Oyun mantığı |
| WorldServer | 17001 | - | Dünya yönetimi |
| MasterServer | 13001 | 3001 | Sunucu yönetimi |
| DBServer | 18001 | - | Veritabanı |

### Bağlantı Adresi

- **IP:** `127.0.0.1` (localhost - yerel test için)
- **Production:** Sunucunun gerçek IP adresi

---

## Test Senaryosu

### 1. Sunucuları Başlatın
```powershell
cd C:\Users\ismail\Desktop\NoahGameFrame1\_Out
.\rund.bat
```

### 2. Client'ı Başlatın

**Unity Client:**
- Unity Editor'de Play butonuna basın
- Veya build edilmiş executable'ı çalıştırın

**WebSocket Client:**
- `websocket_chat_demo.htm` dosyasını tarayıcıda açın
- `ws://127.0.0.1:25001` adresine bağlanın

### 3. Bağlantıyı Kontrol Edin

**Sunucu loglarını kontrol edin:**
```powershell
Get-Content "_Out\Debug\proxy_server_info_*.log" -Tail 20
```

**Başarılı bağlantı mesajı:**
```
[INFO] Client connected: 127.0.0.1:xxxxx
```

---

## Sorun Giderme

### Client Bağlanamıyor

1. **Sunucuların çalıştığından emin olun:**
   ```powershell
   Get-Process -Name "NFServer"
   ```

2. **Portların açık olduğunu kontrol edin:**
   ```powershell
   Test-NetConnection -ComputerName 127.0.0.1 -Port 15001
   ```

3. **Firewall kontrolü:**
   - Windows Firewall'ın portları engellemediğinden emin olun

### Protobuf Hataları

1. **Protobuf dosyalarının kopyalandığından emin olun**
2. **Unity'de script hatalarını kontrol edin:**
   - `Window` → `General` → `Console`
   - Hataları kontrol edin

### Bağlantı Zaman Aşımı

1. **Sunucu IP adresini kontrol edin**
2. **Port numarasını kontrol edin**
3. **Sunucu loglarını kontrol edin**

---

## Özet

### Unity Client (Önerilen)
1. ✅ Unity Hub ve Editor kur
2. ✅ NFUnitySDK indir
3. ✅ Unity projesini aç
4. ✅ Sunucu bağlantı ayarlarını yap
5. ✅ Protobuf dosyalarını kopyala
6. ✅ Test et

### WebSocket Client (Hızlı Test)
1. ✅ `websocket_chat_demo.htm` dosyasını aç
2. ✅ `ws://127.0.0.1:25001` adresine bağlan
3. ✅ Test et

### C++ Client (Gelişmiş)
1. ✅ Client kodunu yaz
2. ✅ Protobuf dosyalarını kullan
3. ✅ Sunucuya bağlan
4. ✅ Test et

---

## Sonraki Adımlar

1. **Client'ı başlatın**
2. **Sunucuya bağlanın**
3. **Test mesajları gönderin**
4. **Oyun mekaniğini geliştirin**

**Kolay gelsin!** 🚀

