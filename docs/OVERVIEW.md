# Black Fox Config Builder — معرفی جامع و مشخصات اپلیکیشن

<div dir="rtl">

## ۱. معرفی و مشخصات هویتی اپلیکیشن

* **نام رسمی برنامه:** Black Fox Config Builder
* **شناسه پکیج (Package Name / Application ID):** `net.foxnext.configbuilder`
* **نسخه کنونی (Version):** `1.1.4+9` (`versionName: 1.1.4`, `versionCode: 9`)
* **سیستم‌عامل هدف:** اندروید (حداقل Android 6.0 / API 23 تا Android 14+ / API 34+)
* **پلتفرم و معماری توسعه:** هیبرید فلاتر + گو (`Flutter 3.3+` + `Go 1.22+ via gomobile`)
* **اکوسیستم:** Black Fox / foxnext.net

---

## ۲. هدف و فلسفه طراحی

اپلیکیشن **Black Fox Config Builder** یک ابزار تخصصی و سبک برای مدیران، پشتیبان‌ها و اپراتورهای سرور است که از پنل‌های مدیریت **3X-UI** استفاده می‌کنند. 

> **توجه مهم:** این اپلیکیشن کلاینت اتصال به VPN نیست و هسته داخلی Xray/V2Ray ندارد؛ بلکه یک پنل مدیریتی سریع است که به صورت مستقیم با API پنل ۳X-UI ارتباط برقرار کرده و فرآیند ساخت، اشتراک و خروجی کانفیگ‌ها را بدون نیاز به ورود به مرورگر یا محیط وب پنل انجام می‌دهد.

---

## ۳. ویژگی‌ها و قابلیت‌های کلیدی

### ۱) اتصال سریع و ایمن به پنل ۳X-UI
* پشتیبانی از پروتکل‌های HTTP و HTTPS.
* احراز هویت با نام‌کاربری و رمزعبور یا API Key.
* ذخیره‌سازی داده‌های حساس و سشن در فضای امن رمزنگاری‌شده سخت‌افزاری (`flutter_secure_storage`).
* سنجش و تست آنی وضعیت اتصال پنل بدون وقفه.

### ۲) ساخت کانفیگ اختصاصی تکی (Single Config Creation)
* تولید خودکار نام رندوم یا انتخاب نام دلخواه.
* تنظیم محدودیت ترافیک (گیگابایت) و مدت اعتبار زمانی (روز).
* پشتیبانی از پروتکل‌های مختلف ورودی نظیر VLESS، VMess، Trojan و Shadowsocks.
* انتخاب پورت و شناسه Inbound دلخواه.

### ۳) ساخت گروهی و دسته‌ای (Bulk Creation)
* امکان صدور ده‌ها یا صدها کانفیگ به صورت هم‌زمان با الگوی نام‌گذاری مشخص (Remark Pattern).
* تعیین سقف حجم و زمان یکسان برای تمامی کانفیگ‌های یک دسته.

### ۴) بارکد QR آنی و لینک اشتراک
* رندر فوری و باکیفیت QR Code برای اسکن توسط دوربین دستگاه کاربر.
* کپی با یک لمس برای لینک مستقیم کانفیگ یا لینک اشتراک (Subscription URL).

### ۵) مدیریت سوابق و خروجی محلی (Records & History)
* ثبت سوابق کانفیگ‌های ساخته‌شده در حافظه دستگاه.
* جستجو، فیلتر و امکان حذف مستقیم کلاینت از روی سرور ۳X-UI.
* خروجی با فرمت‌های مختلف (TXT، CSV، JSON، فرمت لینک اشتراک).

### ۶) به‌روزرسانی خودکار درون‌برنامه‌ای
* بررسی فید نسخه‌های جدید با سرویس اختصاصی `update_service`.
* دانلود و نصب مستقیم فایل APK از طریق `ApkInstaller` و نیتیو `FileProvider`.

---

## ۴. زبان‌های پشتیبانی‌شده (۱۰ زبان زنده)

این برنامه دارای سیستم چندزبانه کامل (i18n / l10n) بوده و هر دو حالت راست‌چین (RTL) و چپ‌چین (LTR) را به شکل کاملاً استاندارد پشتیبانی می‌کند:

| ردیف | زبان | کد زبان | نام بومی | وضعیت نوشتار |
|:---:|:---|:---:|:---|:---:|
| ۱ | فارسی | `fa` | فارسی | راست‌چین (RTL) |
| ۲ | انگلیسی | `en` | English | چپ‌چین (LTR) |
| ۳ | روسی | `ru` | Русский | چپ‌چین (LTR) |
| ۴ | چینی | `zh` | 中文 | چپ‌چین (LTR) |
| ۵ | آلمانی | `de` | Deutsch | چپ‌چین (LTR) |
| ۶ | ترکی استانبولی | `tr` | Türkçe | چپ‌چین (LTR) |
| ۷ | ازبکی | `uz` | Oʻzbek | چپ‌چین (LTR) |
| ۸ | اندونزیایی | `id` | Bahasa Indonesia | چپ‌چین (LTR) |
| ۹ | اوکراینی | `uk` | Українська | چپ‌چین (LTR) |
| ۱۰ | هندی | `hi` | हिन्दी | چپ‌چین (LTR) |

---

## ۵. مشخصات ساختار دایرکتوری و معماری کد

```text
Mobile Android/
├── go/                            # هسته ارتباط با API ۳X-UI به زبان Go
│   ├── api.go                     # روت‌های ورودی به کتابخانه موبایل
│   ├── threexui.go                # کلاینت HTTP و لاجیک درخواست‌های ۳X-UI
│   └── types.go                   # ساختارهای داده و مدل‌ها
├── flutter/                       # رابط کاربری Flutter
│   ├── android/                   # کدهای نیتیو اندروید و متد چنل (MethodChannel)
│   ├── lib/
│   │   ├── core/theme/            # پالت رنگی اختصاصی FoxColors و دارک‌مود
│   │   ├── l10n/                  # فایل‌های ترجمه ۱۰ زبان
│   │   ├── models/                # مدل‌های داده و کانفیگ
│   │   ├── screens/               # صفحات (Connection, Create, Bulk, List, Settings, Contact)
│   │   └── services/              # سرویس‌های ذخیره‌سازی، آپدیت و تعامل با هسته Go
│   └── pubspec.yaml               # مشخصات پکیج و وابستگی‌ها
└── scripts/                       # اسکریپت‌های PowerShell برای کامپایل و انتشار
```

---

## ۶. دستورات اجرایی بیلد و ساخت پکیج

```powershell
# ۱) کامپایل کتابخانه Go برای اندروید (AAR)
.\Mobile Android\scripts\build-gomobile.ps1

# ۲) ساخت فایل نصبی APK نهایی (Universal / arm64)
.\Mobile Android\scripts\build-release.ps1

# ۳) ساخت پکیج Google Play (شامل App Bundle .aab و APKهای مجزا بر اساس معماری)
.\Mobile Android\scripts\build-play-store.ps1
```

---

## ۷. متون رسمی فروشگاه برنامه (Store Metadata)

### شرح مختصر (Short Description — حداکثر ۸۰ کاراکتر)
* **فارسی (۷۰ کاراکتر):**
  `مدیریت و صدور سریع کانفیگ‌های پنل ۳X-UI با تولید QR Code و لینک اشتراک`
* **انگلیسی (۷۴ کاراکتر):**
  `Fast & secure 3X-UI client manager: generate configs, QR codes & sub links`

### توضیحات کامل (Full Description — انگلیسی)
```text
Black Fox Config Builder is a lightweight, high-performance management tool designed for 3X-UI panel administrators. It streamlines client creation, config generation, and subscription handling directly from your Android device—eliminating the need to navigate the web panel interface manually.

Please Note: This application is an administrative client and does not embed a local VPN core. It connects directly to your remote 3X-UI panel to manage accounts and credentials.

Key Features:
• Fast & Secure Connection: Authenticate seamlessly to your 3X-UI panel. Sensitive credentials and cookies are safely encrypted using hardware-backed Android Secure Storage.
• Single Client Issuance: Easily create clients with custom or auto-generated names, flexible traffic quotas (GB), custom expiry periods (days), and targeted inbounds.
• Bulk Config Generator: Generate dozens of client configurations in batch mode with customizable remark patterns within seconds.
• Instant QR Code & Links: Display high-resolution QR codes for immediate device scanning, with one-tap copying for direct connection links and subscription URLs.
• Local Records & Management: Maintain a structured history of all created configurations, filter records, copy credentials, or delete clients directly from the remote panel.
• Export & Sharing: Export generated configs in multiple formats (TXT, CSV, JSON, Subscription links) for hassle-free customer delivery.
• Native Core Performance: Powered by an optimized Go network engine for lightning-fast API transactions and minimal battery consumption.

Multilingual Support (10 Languages):
Fully localized with complete LTR and native RTL support for English, Persian (فارسی), Russian (Русский), Chinese (中文), German (Deutsch), Turkish (Türkçe), Uzbek (Oʻzbek), Indonesian (Bahasa Indonesia), Ukrainian (Українська), and Hindi (हिन्दी).
```

</div>
