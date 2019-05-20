# Country Name utils for Crystal

Lookups country name from ISO 3166-1(Alpha 2) country code.

## Installation

1. Add the dependency to your `shard.yml`: 

   ```yaml
   dependencies: 
     country_name: 
       github: arcage/country_name.cr
   ```

2. Run `shards install`

## Usage

```crystal
require "country_code"

# Basic lookup(case insensitive)
CountryName.from_country_code("jp") #=> "Japan"

# Specify language
CountryName.from_country_code("jp", "ja") #=> "日本"

# Set default language
CountryName.default_lnag = "ja"
CountryName.from_country_code("jp") #=> "日本"

# An exception is raised when the code doesn't exist.
CountryName.from_country_code("xx")
#>> Unhandled exception: Country code "xx" not found. (CountryName::Error)

# from_country_code? method returns nil when the code doesn't exist.
CountryName.from_country_code("xx") #=> nil
```

## Supported languages

Afrikaans(`af`), Akan(`ak`), Amharic(`am`), Arabic(`ar`), Assamese(`as`), Azerbaijani(`az`), Belarusian(`be`), Bulgarian(`bg`), Bambara(`bm`), Bengali(`bn`), Tibetan(`bo`), Breton(`br`), Bosnian(`bs`), Catalan/Valencian(`ca`), Chechen(`ce`), Czech(`cs`), Welsh(`cy`), Danish(`da`), German(`de`), Dzongkha(`dz`), Ewe(`ee`), Greek(Modern)(`el`), English(`en`), Esperanto(`eo`), Spanish/Castilian(`es`), Estonian(`et`), Basque(`eu`), Persian(`fa`), Fulah(`ff`), Finnish(`fi`), Faroese(`fo`), French(`fr`), Western Frisian(`fy`), Irish(`ga`), Gaelic/Scottish Gaelic(`gd`), Galician(`gl`), Gujarati(`gu`), Manx(`gv`), Hausa(`ha`), Hebrew(`he`), Hindi(`hi`), Croatian(`hr`), Hungarian(`hu`), Armenian(`hy`), Interlingua(International Auxiliary Language Association)(`ia`), Indonesian(`id`), Igbo(`ig`), Sichuan Yi/Nuosu(`ii`), Icelandic(`is`), Italian(`it`), Japanese(`ja`), Javanese(`jv`), Georgian(`ka`), Kikuyu/Gikuyu(`ki`), Kazakh(`kk`), Kalaallisut/Greenlandic(`kl`), Central Khmer(`km`), Kannada(`kn`), Korean(`ko`), Kashmiri(`ks`), Kurdish(`ku`), Cornish(`kw`), Kirghiz/Kyrgyz(`ky`), Luxembourgish/Letzeburgesch(`lb`), Ganda(`lg`), Lingala(`ln`), Lao(`lo`), Lithuanian(`lt`), Luba-Katanga(`lu`), Latvian(`lv`), Malagasy(`mg`), Maori(`mi`), Macedonian(`mk`), Malayalam(`ml`), Mongolian(`mn`), Marathi(`mr`), Malay(`ms`), Maltese(`mt`), Burmese(`my`), Norwegian Bokmål(`nb`), North Ndebele(`nd`), Nepali(`ne`), Dutch/Flemish(`nl`), Norwegian Nynorsk(`nn`), Norwegian(`no`), Oromo(`om`), Oriya(`or`), Ossetian/Ossetic(`os`), Panjabi/Punjabi(`pa`), Polish(`pl`), Pashto/Pushto(`ps`), Portuguese(`pt`), Quechua(`qu`), Romansh(`rm`), Rundi(`rn`), Romanian/Moldavian/Moldovan(`ro`), Russian(`ru`), Kinyarwanda(`rw`), Sindhi(`sd`), Northern Sami(`se`), Sango(`sg`), Serbo-Croatian(`sh`), Sinhala/Sinhalese(`si`), Slovak(`sk`), Slovenian(`sl`), Shona(`sn`), Somali(`so`), Albanian(`sq`), Serbian(`sr`), Swedish(`sv`), Swahili(`sw`), Tamil(`ta`), Telugu(`te`), Tajik(`tg`), Thai(`th`), Tigrinya(`ti`), Turkmen(`tk`), Tagalog(`tl`), Tonga(Tonga Islands)(`to`), Turkish(`tr`), Tatar(`tt`), Uighur/Uyghur(`ug`), Ukrainian(`uk`), Urdu(`ur`), Uzbek(`uz`), Vietnamese(`vi`), Wolof(`wo`), Xhosa(`xh`), Yiddish(`yi`), Yoruba(`yo`), Chinese(`zh`), Zulu(`zu`)

## Special thanks

This library uses conversion tables(**ISO 3166-1 alpha-2** country codes to country names) provided by [umpirsky/country-list](https://github.com/umpirsky/country-list) &copy; Saša Stamenković <umpirsky@gmail.com>(license is  [here](https://github.com/umpirsky/country-list/blob/master/LICENSE)).

It supports many kinds of file formats(CSV, JSON, YAML, etc...) and many kinds of languages.

I sincerely respect this great work.

## Contributors

- [ʕ·ᴥ·ʔAKJ](https://github.com/arcage) - creator and maintainer
