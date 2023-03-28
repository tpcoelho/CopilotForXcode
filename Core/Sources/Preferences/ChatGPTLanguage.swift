import Foundation

public enum Language: String {
    case somali = "Somali"
    case afrikaans = "Afrikaans"
    case azerbaijani = "Azerbaijani"
    case indonesian = "Indonesian"
    case malaysianMalay = "Malaysian Malay"
    case malay = "Malay"
    case javanese = "Javanese"
    case sundanese = "Sundanese"
    case bosnian = "Bosnian"
    case catalan = "Catalan"
    case czech = "Czech"
    case chichewa = "Chichewa"
    case welsh = "Welsh"
    case danish = "Danish"
    case german = "German"
    case estonian = "Estonian"
    case english = "English"
    case englishUK = "English (UK)"
    case englishUS = "English (US)"
    case spanish = "Spanish"
    case esperanto = "Esperanto"
    case basque = "Basque"
    case french = "French"
    case irish = "Irish"
    case galician = "Galician"
    case croatian = "Croatian"
    case xhosa = "Xhosa"
    case zulu = "Zulu"
    case icelandic = "Icelandic"
    case italian = "Italian"
    case swahili = "Swahili"
    case haitianCreole = "Haitian Creole"
    case kurdish = "Kurdish"
    case latin = "Latin"
    case latvian = "Latvian"
    case luxembourgish = "Luxembourgish"
    case lithuanian = "Lithuanian"
    case hungarian = "Hungarian"
    case malagasy = "Malagasy"
    case maltese = "Maltese"
    case maori = "Maori"
    case dutch = "Dutch"
    case norwegian = "Norwegian"
    case uzbek = "Uzbek"
    case polish = "Polish"
    case portuguese = "Portuguese"
    case romanian = "Romanian"
    case sesotho = "Sesotho"
    case albanian = "Albanian"
    case slovak = "Slovak"
    case slovenian = "Slovenian"
    case finnish = "Finnish"
    case swedish = "Swedish"
    case tagalog = "Tagalog"
    case tatar = "Tatar"
    case turkish = "Turkish"
    case vietnamese = "Vietnamese"
    case yoruba = "Yoruba"
    case greek = "Greek"
    case belarusian = "Belarusian"
    case bulgarian = "Bulgarian"
    case kyrgyz = "Kyrgyz"
    case kazakh = "Kazakh"
    case macedonian = "Macedonian"
    case mongolian = "Mongolian"
    case russian = "Russian"
    case serbian = "Serbian"
    case tajik = "Tajik"
    case ukrainian = "Ukrainian"
    case georgian = "Georgian"
    case armenian = "Armenian"
    case yiddish = "Yiddish"
    case hebrew = "Hebrew"
    case uyghur = "Uyghur"
    case urdu = "Urdu"
    case arabic = "Arabic"
    case pashto = "Pashto"
    case persian = "Persian"
    case nepali = "Nepali"
    case marathi = "Marathi"
    case hindi = "Hindi"
    case bengali = "Bengali"
    case punjabi = "Punjabi"
    case gujarati = "Gujarati"
    case oriya = "Oriya"
    case tamil = "Tamil"
    case telugu = "Telugu"
    case kannada = "Kannada"
    case malayalam = "Malayalam"
    case sinhala = "Sinhala"
    case thai = "Thai"
    case lao = "Lao"
    case burmese = "Burmese"
    case khmer = "Khmer"
    case korean = "Korean"
    case chinese = "Chinese"
    case traditionalChinese = "Traditional Chinese"
    case japanese = "Japanese"
}

extension Language {
    var name: String {
        switch self {
        case .somali: return "Af Soomaali"
        case .afrikaans: return "Afrikaans"
        case .azerbaijani: return "Azərbaycan dili"
        case .indonesian: return "Bahasa Indonesia"
        case .malaysianMalay: return "Bahasa Malaysia"
        case .malay: return "Bahasa Melayu"
        case .javanese: return "Basa Jawa"
        case .sundanese: return "Basa Sunda"
        case .bosnian: return "Bosanski jezik"
        case .catalan: return "Català"
        case .czech: return "Čeština"
        case .chichewa: return "Chichewa"
        case .welsh: return "Cymraeg"
        case .danish: return "Dansk"
        case .german: return "Deutsch"
        case .estonian: return "Eesti keel"
        case .english: return "English"
        case .englishUK: return "English (UK)"
        case .englishUS: return "English (US)"
        case .spanish: return "Español"
        case .esperanto: return "Esperanto"
        case .basque: return "Euskara"
        case .french: return "Français"
        case .irish: return "Gaeilge"
        case .galician: return "Galego"
        case .croatian: return "Hrvatski jezik"
        case .xhosa: return "isiXhosa"
        case .zulu: return "isiZulu"
        case .icelandic: return "Íslenska"
        case .italian: return "Italiano"
        case .swahili: return "Kiswahili"
        case .haitianCreole: return "Kreyòl Ayisyen"
        case .kurdish: return "Kurdî"
        case .latin: return "Latīna"
        case .latvian: return "Latviešu valoda"
        case .luxembourgish: return "Lëtzebuergesch"
        case .lithuanian: return "Lietuvių kalba"
        case .hungarian: return "Magyar"
        case .malagasy: return "Malagasy"
        case .maltese: return "Malti"
        case .maori: return "Māori"
        case .dutch: return "Nederlands"
        case .norwegian: return "Norsk"
        case .uzbek: return "O'zbek tili"
        case .polish: return "Polski"
        case .portuguese: return "Português"
        case .romanian: return "Română"
        case .sesotho: return "Sesotho"
        case .albanian: return "Shqip"
        case .slovak: return "Slovenčina"
        case .slovenian: return "Slovenščina"
        case .finnish: return "Suomi"
        case .swedish: return "Svenska"
        case .tagalog: return "Tagalog"
        case .tatar: return "Tatarça"
        case .turkish: return "Türkçe"
        case .vietnamese: return "Việt ngữ"
        case .yoruba: return "Yorùbá"
        case .greek: return "Ελληνικά"
        case .belarusian: return "Беларуская мова"
        case .bulgarian: return "Български език"
        case .kyrgyz: return "Кыр"
        case .kazakh: return "Қазақ тілі"
        case .macedonian: return "Македонски јазик"
        case .mongolian: return "Монгол хэл"
        case .russian: return "Русский"
        case .serbian: return "Српски језик"
        case .tajik: return "Тоҷикӣ"
        case .ukrainian: return "Українська"
        case .georgian: return "ქართული"
        case .armenian: return "Հայերեն"
        case .yiddish: return "ייִדיש"
        case .hebrew: return "עברית"
        case .uyghur: return "ئۇيغۇرچە"
        case .urdu: return "اردو"
        case .arabic: return "العربية"
        case .pashto: return "پښتو"
        case .persian: return "فارسی"
        case .nepali: return "नेपाली"
        case .marathi: return "मराठी"
        case .hindi: return "हिन्दी"
        case .bengali: return "বাংলা"
        case .punjabi: return "ਪੰਜਾਬੀ"
        case .gujarati: return "ગુજરાતી"
        case .oriya: return "ଓଡ଼ିଆ"
        case .tamil: return "தமிழ்"
        case .telugu: return "తెలుగు"
        case .kannada: return "ಕನ್ನಡ"
        case .malayalam: return "മലയാളം"
        case .sinhala: return "සිංහල"
        case .thai: return "ไทย"
        case .lao: return "ພາສາລາວ"
        case .burmese: return "ဗမာစာ"
        case .khmer: return "ភាសាខ្មែរ"
        case .korean: return "한국어"
        case .chinese: return "中文"
        case .traditionalChinese: return "繁體中文"
        case .japanese: return "日本語"
        }
    }
}

extension Language: CaseIterable {}
