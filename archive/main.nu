let consonants = [
	b c d f g h j k m n p r s t v w xx y z
	kg sg tg ng hg mg rg gg dg bg
]

let vowels = [a i u e o]
let azik_vowels = [
	[d e ん]
	[h u う]
	[j u ん]
	[k i ん]
	[l o ん]
	[p o う]
	[q a い]
	[w e い]
	[y i い]
	[z a ん]
]

let default = {
	'a': ['' あ], 'i': ['' い], 'u': ['' う], 'e': ['' え], 'o': ['' お],
	'ka': ['' か], 'ki': ['' き], 'ku': ['' く], 'ke': ['' け], 'ko': ['' こ],
	'sa': ['' さ], 'si': ['' し], 'su': ['' す], 'se': ['' せ], 'so': ['' そ],
	'ta': ['' た], 'ti': ['' ち], 'tu': ['' つ], 'te': ['' て], 'to': ['' と],
	'na': ['' な], 'ni': ['' に], 'nu': ['' ぬ], 'ne': ['' ね], 'no': ['' の],
	'ha': ['' は], 'hi': ['' ひ], 'hu': ['' ふ], 'he': ['' へ], 'ho': ['' ほ],
	'ma': ['' ま], 'mi': ['' み], 'mu': ['' む], 'me': ['' め], 'mo': ['' も],
	'ya': ['' や], 'yi': ['' ゐ], 'yu': ['' ゆ], 'ye': ['' いぇ], 'yo': ['' よ],
	'ra': ['' ら], 'ri': ['' り], 'ru': ['' る], 're': ['' れ], 'ro': ['' ろ],
	'wa': ['' わ], 'wi': ['' うぃ], 'wu': ['' う], 'we': ['' うぇ], 'wo': ['' を],
	'ga': ['' が], 'gi': ['' ぎ], 'gu': ['' ぐ], 'ge': ['' げ], 'go': ['' ご],
	'za': ['' ざ], 'zi': ['' じ], 'zu': ['' ず], 'ze': ['' ぜ], 'zo': ['' ぞ],
	'da': ['' だ], 'di': ['' ぢ], 'du': ['' づ], 'de': ['' で], 'do': ['' ど],
	'ba': ['' ば], 'bi': ['' び], 'bu': ['' ぶ], 'be': ['' べ], 'bo': ['' ぼ],
	'pa': ['' ぱ], 'pi': ['' ぴ], 'pu': ['' ぷ], 'pe': ['' ぺ], 'po': ['' ぽ],
	'fa': ['' ふぁ], 'fi': ['' ふぃ], 'fu': ['' ふ], 'fe': ['' ふぇ], 'fo': ['' ふぉ],
	'ja': ['' じゃ], 'ji': ['' じ], 'ju': ['' じゅ], 'je': ['' じぇ], 'jo': ['' じょ],
	'kga': ['' きゃ], 'kgi': ['' きぃ], 'kgu': ['' きゅ], 'kge': ['' きぇ],	'kgo': ['' きょ],
	'sga': ['' しゃ], 'sgi': ['' しぃ], 'sgu': ['' しゅ], 'sge': ['' しぇ], 'sgo': ['' しょ],
	'tga': ['' ちゃ], 'tgi': ['' ちぃ], 'tgu': ['' ちゅ], 'tge': ['' ちぇ], 'tgo': ['' ちょ],
	'nga': ['' にゃ], 'ngi': ['' にぃ], 'ngu': ['' にゅ], 'nge': ['' にぇ], 'ngo': ['' にょ],
	'hga': ['' ひゃ], 'hgi': ['' ひぃ], 'hgu': ['' ひゅ], 'hge': ['' ひぇ], 'hgo': ['' ひょ],
	'mga': ['' みゃ], 'mgi': ['' みぃ], 'mgu': ['' みゅ], 'mge': ['' みぇ], 'mgo': ['' みょ],
	'rga': ['' りゃ], 'rgi': ['' りぃ], 'rgu': ['' りゅ], 'rge': ['' りぇ], 'rgo': ['' りょ],
	'gga': ['' ぎゃ], 'ggi': ['' ぎぃ], 'ggu': ['' ぎゅ], 'gge': ['' ぎぇ], 'ggo': ['' ぎょ],
	'dga': ['' ぢゃ], 'dgi': ['' ぢぃ], 'dgu': ['' ぢゅ], 'dge': ['' ぢぇ], 'dgo': ['' ぢょ],
	'bga': ['' びゃ], 'bgi': ['' びぃ], 'bgu': ['' びゅ], 'bge': ['' びぇ], 'bgo': ['' びょ],
	'xxa': ['' ぁ], 'xxi': ['' ぃ], 'xxu': ['' ぅ], 'xxe': ['' ぇ], 'xxo': ['' ぉ],
}

let azik_binds = $consonants
| each {|c|
	$azik_vowels
	| each {|v|
		[($c + $v.0) ['' (($default | get ($c + $v.1) | get 1) + $v.2)]]
		| into record
	}
}

let defaultconf = {
	define: {
		rom-kana: {
			st: ['' 'した'],
		}
	}
}

$default | merge $azik_binds | merge $defaultconf | save -f temp.json
