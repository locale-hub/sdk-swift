public enum Language: CaseIterable, Codable, CustomStringConvertible {
    fileprivate static func from(code: String) -> Language? {
        for language in Language.allCases {
            if language.code.caseInsensitiveCompare(code) == .orderedSame {
                return language
            }
        }
        return nil
    }
    
    public init?(code: String) {
        if let culture = Language.from(code: code) {
            self = culture
        } else {
            return nil
        }
    }
    
    public init(from decoder: Decoder) throws {
        let cultureCode = try decoder.singleValueContainer().decode(String.self)
        
        if let culture = Language.from(code: cultureCode) {
            self = culture
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Invalid ISO639 code"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.code)
    }
    
    public var description: String {
        self.nativeDescription
    }
    
    case af
    case ar
    case `as`
    case asa
    case az
    case bas
    case be
    case bem
    case bez
    case bg
    case bm
    case bn
    case bo
    case br
    case brx
    case bs
    case ca
    case ce
    case cgg
    case chr
    case cs
    case cy
    case da
    case dav
    case de
    case dje
    case dsb
    case dua
    case dv
    case dyo
    case dz
    case ebu
    case ee
    case el
    case en
    case eo
    case es
    case et
    case eu
    case ewo
    case fa
    case ff
    case fi
    case fil
    case fo
    case fr
    case fur
    case fy
    case ga
    case gd
    case gl
    case gsw
    case gu
    case guz
    case gv
    case ha
    case haw
    case he
    case hi
    case hr
    case hsb
    case hu
    case hy
    case id
    case ig
    case ii
    case `in`
    case `is`
    case it
    case iw
    case ja
    case jgo
    case jmc
    case ka
    case kab
    case kam
    case kde
    case kea
    case khq
    case ki
    case kk
    case kkj
    case kl
    case kln
    case km
    case kn
    case ko
    case kok
    case ks
    case ksb
    case ksf
    case ksh
    case kw
    case ky
    case lag
    case lb
    case lg
    case lt
    case lv
    case mi
    case mk
    case mn
    case mr
    case ms
    case mt
    case nb
    case nl
    case nn
    case no
    case ns
    case pa
    case pl
    case ps
    case pt
    case qu
    case ro
    case ru
    case sa
    case se
    case sk
    case sl
    case sq
    case sr
    case sv
    case sw
    case syr
    case ta
    case te
    case th
    case tl
    case tn
    case tr
    case ts
    case tt
    case uk
    case ur
    case uz
    case vi
    case xh
    case zh
    case zu
}
