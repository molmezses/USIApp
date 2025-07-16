//
//  ContactInfoViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 12.07.2025.
//

import Foundation

enum ContactInfoEnum {
    case telNo
    case email
    case web
    case kurum
}

class ContactInfoViewModel: ObservableObject{
    
    let cities = [
        "İl", "Adana", "Adıyaman", "Afyonkarahisar", "Ağrı", "Aksaray", "Amasya",
        "Ankara", "Antalya", "Ardahan", "Artvin", "Aydın", "Balıkesir", "Bartın",
        "Batman", "Bayburt", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur",
        "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Düzce",
        "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun",
        "Gümüşhane", "Hakkari", "Hatay", "Iğdır", "Isparta", "İstanbul", "İzmir",
        "Kahramanmaraş", "Karabük", "Karaman", "Kars", "Kastamonu", "Kayseri",
        "Kırıkkale", "Kırklareli", "Kırşehir", "Kilis", "Kocaeli", "Konya", "Kütahya",
        "Malatya", "Manisa", "Mardin", "Mersin", "Muğla", "Muş", "Nevşehir", "Niğde",
        "Ordu", "Osmaniye", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas",
        "Şanlıurfa", "Şırnak", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Uşak",
        "Van", "Yalova", "Yozgat", "Zonguldak"
    ]
    
    let districts: [String: [String]] = [
        "Adana": ["Seyhan", "Çukurova", "Yüreğir", "Sarıçam", "Ceyhan", "Karaisalı", "Pozantı", "Feke", "İmamoğlu", "Tufanbeyli", "Aladağ", "Saimbeyli"],
        "Adıyaman": ["Merkez", "Besni", "Kahta", "Gerger", "Samsat", "Çelikhan", "Tut", "Gölbaşı", "Sincik"],
        "Afyonkarahisar": ["Merkez", "Sandıklı", "Dazkırı", "İscehisar", "Emirdağ", "Bolvadin", "Çay", "Sultandağı", "Başmakçı", "Dinar", "Evciler", "Şuhut"],
        "Ağrı": ["Merkez", "Diyadin", "Doğubayazıt", "Eleşkirt", "Patnos", "Taşlıçay", "Tutak"],
        "Aksaray": ["Merkez", "Eskil", "Gülağaç", "Güzelyurt", "Ortaköy", "Sarıyahşi"],
        "Amasya": ["Merkez", "Göynücek", "Gümüşhacıköy", "Hamamözü", "Merzifon", "Suluova", "Taşova"],
        "Ankara": ["Altındağ", "Ayaş", "Bala", "Çamlıdere", "Çankaya", "Çubuk", "Elmadağ", "Gölbaşı", "Haymana", "Kalecik", "Kazan", "Keçiören", "Kızılcahamam", "Nallıhan", "Polatlı", "Şereflikoçhisar", "Yenimahalle"],
        "Antalya": ["Alanya", "Akseki", "Aksu", "Demre", "Döşemealtı", "Elmalı", "Finike", "Gazipaşa", "Gündoğmuş", "İbradı", "Kaş", "Kemer", "Konyaaltı", "Korkuteli", "Kumluca", "Manavgat", "Muratpaşa", "Serik"],
        "Ardahan": ["Merkez", "Çıldır", "Damala", "Göle", "Hanak", "Posof"],
        "Artvin": ["Merkez", "Arhavi", "Borçka", "Hopa", "Murgul", "Şavşat", "Yusufeli"],
        "Aydın": ["Merkez", "Bozdoğan", "Çine", "Germencik", "İncirliova", "Kuşadası", "Koçarlı", "Nazilli", "Söke", "Sultanhisar", "Didim", "Karacasu"],
        "Balıkesir": ["Merkez", "Altıeylül", "Karesi", "Ayvalık", "Balya", "Bandırma", "Bigadiç", "Burhaniye", "Dursunbey", "Edremit", "Erdek", "Gönen", "Havran", "İvrindi", "Kepsut", "Manyas", "Marmara", "Savaştepe", "Sındırgı", "Susurluk"],
        "Bartın": ["Merkez", "Kurucaşile", "Ulus", "Amasra"],
        "Batman": ["Merkez", "Beşiri", "Gercüş", "Hasankeyf", "Kozluk", "Sason"],
        "Bayburt": ["Merkez", "Aydıntepe", "Demirözü"],
        "Bilecik": ["Merkez", "Bozüyük", "Gölpazarı", "Osmaneli", "Pazaryeri", "Söğüt", "Yenipazar"],
        "Bingöl": ["Merkez", "Adaklı", "Genç", "Karlıova", "Kiğı", "Solhan", "Yayladere", "Yedisu"],
        "Bitlis": ["Merkez", "Adilcevaz", "Ahlat", "Güroymak", "Hizan", "Mutki", "Tatvan"],
        "Bolu": ["Merkez", "Dörtdivan", "Göynük", "Kıbrıscık", "Mengen", "Mudurnu", "Seben", "Yeniçağa"],
        "Burdur": ["Merkez", "Ağlasun", "Altınyayla", "Bucak", "Çavdır", "Çeltikçi", "Gölhisar", "Karamanlı", "Tefenni", "Yeşilova"],
        "Bursa": ["Nilüfer", "Osmangazi", "Yıldırım", "İnegöl", "Gemlik", "Orhaneli", "Mudanya", "Kestel", "Mustafakemalpaşa", "Karacabey", "Yenişehir", "Harmancık", "Gürsu", "Karamürsel", "İznik"],
        "Çanakkale": ["Merkez", "Ayvacık", "Bayramiç", "Biga", "Bozcaada", "Çan", "Eceabat", "Ezine", "Gelibolu", "Gökçeada", "Lapseki", "Yenice"],
        "Çankırı": ["Merkez", "Atkaracalar", "Bayramören", "Çerkeş", "Eldivan", "Ilgaz", "Kızılırmak", "Kurşunlu", "Orta", "Şabanözü", "Yapraklı"],
        "Çorum": ["Merkez", "Alaca", "Bayat", "İskilip", "Kargı", "Mecitözü", "Ortaköy", "Osmancık", "Sungurlu", "Boğazkale"],
        "Denizli": ["Merkez", "Acıpayam", "Babadağ", "Baklan", "Bekilli", "Beyağaç", "Bozkurt", "Çal", "Çameli", "Çardak", "Çivril", "Güney", "Honaz", "Kale", "Sarayköy", "Tavas"],
        "Diyarbakır": ["Merkez", "Bağlar", "Kayapınar", "Sur", "Yenişehir", "Bismil", "Çermik", "Çınar", "Dicle", "Ergani", "Hani", "Hazro", "Kulp", "Lice", "Silvan", "Eğil", "Kocaköy"],
        "Düzce": ["Merkez", "Akçakoca", "Yığılca", "Cumayeri", "Gölyaka", "Çilimli"],
        "Edirne": ["Merkez", "Enez", "Havsa", "İpsala", "Keşan", "Lalapaşa", "Meriç", "Süloğlu"],
        "Elazığ": ["Merkez", "Ağın", "Alacakaya", "Arıcak", "Baskil", "Karakoçan", "Keban", "Maden", "Palu", "Sivrice"],
        "Erzincan": ["Merkez", "Çayırlı", "İliç", "Kemah", "Kemaliye", "Otlukbeli", "Refahiye", "Tercan", "Üzümlü"],
        "Erzurum": ["Merkez", "Aşkale", "Aziziye", "Çat", "Hınıs", "Horasan", "İspir", "Narman", "Olur", "Palandöken", "Pazaryolu", "Tekman", "Tortum", "Karaçoban", "Uzundere"],
        "Eskişehir": ["Merkez", "Alpu", "Beylikova", "Çifteler", "Günyüzü", "Han", "İnönü", "Mahmudiye", "Mihalgazi", "Mihalıççık", "Sarıcakaya", "Seyitgazi", "Sivrihisar"],
        "Gaziantep": ["Şahinbey", "Şehitkamil", "Nizip", "Araban", "İslahiye", "Karkamış", "Yavuzeli"],
        "Giresun": ["Merkez", "Alucra", "Bulancak", "Çamoluk", "Çanakçı", "Dereli", "Doğankent", "Espiye", "Eynesil", "Görele", "Güce", "Keşap", "Piraziz", "Şebinkarahisar", "Tirebolu", "Yağlıdere"],
        "Gümüşhane": ["Merkez", "Kelkit", "Şiran", "Torul"],
        "Hakkari": ["Merkez", "Çukurca", "Şemdinli", "Yüksekova"],
        "Hatay": ["Antakya", "Defne", "Dörtyol", "Erzin", "Hassa", "İskenderun", "Kırıkhan", "Kumlu", "Payas", "Reyhanlı", "Samandağ", "Yayladağı"],
        "Iğdır": ["Merkez", "Aralık", "Tuzluca", "Karakoyunlu"],
        "Isparta": ["Merkez", "Atabey", "Eğirdir", "Gelendost", "Gönen", "Senirkent", "Sütçüler", "Şarkikaraağaç", "Uluborlu", "Yalvaç", "Yenişarbademli"],
        "İstanbul": ["Adalar", "Arnavutköy", "Ataşehir", "Avcılar", "Bağcılar", "Bahçelievler", "Bakırköy", "Başakşehir", "Bayrampaşa", "Beşiktaş", "Beykoz", "Beylikdüzü", "Beyoğlu", "Büyükçekmece", "Çatalca", "Çekmeköy", "Esenler", "Esenyurt", "Eyüpsultan", "Fatih", "Gaziosmanpaşa", "Güngören", "Kadıköy", "Kağıthane", "Kartal", "Küçükçekmece", "Maltepe", "Pendik", "Sancaktepe", "Sarıyer", "Şile", "Şişli", "Sultanbeyli", "Sultangazi", "Tuzla", "Ümraniye", "Üsküdar", "Zeytinburnu"],
        "İzmir": ["Aliağa", "Balçova", "Bayındır", "Bayraklı", "Bergama", "Beydağ", "Bornova", "Buca", "Çeşme", "Dikili", "Foça", "Gaziemir", "Güzelbahçe", "Karabağlar", "Karşıyaka", "Kemalpaşa", "Kınık", "Kiraz", "Konak", "Menderes", "Menemen", "Narlıdere", "Ödemiş", "Seferihisar", "Selçuk", "Tire", "Torbalı", "Urla"],
        "Kahramanmaraş": ["Merkez", "Afşin", "Andırın", "Dulkadiroğlu", "Çağlayancerit", "Ekinözü", "Elbistan", "Göksun", "Nurhak", "Pazarcık", "Onikişubat", "Türkoğlu"],
        "Karabük": ["Merkez", "Eflani", "Eskipazar", "Ovacık", "Yenice"],
        "Karaman": ["Merkez", "Ayrancı", "Ermenek", "Kazımkarabekir", "Başyayla"],
        "Kars": ["Merkez", "Akyaka", "Arpaçay", "Digor", "Kağızman", "Sarıkamış", "Selim", "Susuz"],
        "Kastamonu": ["Merkez", "Abana", "Araç", "Bozkurt", "Cide", "Çatalzeytin", "Daday", "Devrekani", "Doğanyurt", "Hanönü", "İnebolu", "İhsangazi", "Küre", "Pınarbaşı", "Şenpazar", "Tosya"],
        "Kayseri": ["Merkez", "Akkışla", "Bünyan", "Develi", "Felahiye", "Hacılar", "İncesu", "Kocasinan", "Melikgazi", "Özvatan", "Pınarbaşı", "Sarıoğlan", "Sarız", "Talas", "Tomarza", "Yahyalı", "Yeşilhisar"],
        "Kırıkkale": ["Merkez", "Bahşılı", "Balışeyh", "Keskin", "Delice", "Karakeçili", "Sulakyurt"],
        "Kırklareli": ["Merkez", "Babaeski", "Demirköy", "Kofçaz", "Lüleburgaz", "Pehlivanköy", "Pınarhisar", "Vize"],
        "Kırşehir": ["Merkez", "Akpınar", "Akçakent","Mucur", "Boztepe", "Çiçekdağı", "Kaman"],
        "Kilistra": ["Merkez", "Akdeniz", "Anamur", "Aydıncık", "Bozyazı", "Çamlıyayla", "Erdemli", "Gülnar", "Mut", "Silifke", "Tarsus", "Toroslar", "Yenişehir"],
        "Kilis": ["Merkez", "Elbeyli", "Musabeyli", "Polateli"],
        "Kocaeli": ["İzmit", "Gebze", "Darıca", "Çayırova", "Körfez", "Kandıra", "Başiskele", "Derince", "Gölcük"],
        "Konya": ["Merkez", "Ahırlı", "Akören", "Altınekin", "Beyşehir", "Bozkır", "Cihanbeyli", "Çeltik", "Derebucak", "Derebucak", "Doğanhisar", "Emirgazi", "Ereğli", "Güneysınır", "Hadim", "Halkapınar", "Hüyük", "Ilgın", "Kadınhanı", "Karapınar", "Karatay", "Kulu", "Sarayönü", "Seydişehir", "Taşkent", "Yunak"],
        "Kütahya": ["Merkez", "Altıntaş", "Domaniç", "Emet", "Gediz", "Simav", "Şaphane", "Tavşanlı"],
        "Malatya": ["Merkez", "Akçadağ", "Arapgir", "Arguvan", "Battalgazi", "Darende", "Doğanşehir", "Hekimhan", "Pütürge", "Yazıhan", "Yeşilyurt"],
        "Manisa": ["Merkez", "Akhisar", "Demirci", "Gördes", "Kırkağaç", "Köprübaşı", "Salihli", "Sarıgöl", "Saruhanlı", "Şehzadeler", "Turgutlu", "Yunusemre"],
        "Mardin": ["Merkez", "Derik", "Dargeçit", "Kızıltepe", "Mazıdağı", "Midyat", "Nusaybin", "Ömerli", "Savur"],
        "Mersin": ["Akdeniz", "Mezitli", "Toroslar", "Yenişehir", "Anamur", "Aydıncık", "Bozyazı", "Çamlıyayla", "Erdemli", "Gülnar", "Mut", "Silifke", "Tarsus"],
        "Muğla": ["Merkez", "Marmaris", "Bodrum", "Fethiye", "Datça", "Dalaman", "Ortaca", "Ula", "Yatağan"],
        "Muş": ["Merkez", "Bulanık", "Hasköy", "Korkut", "Malazgirt", "Varto"],
        "Nevşehir": ["Merkez", "Acıgöl", "Avanos", "Derinkuyu", "Gülşehir", "Hacıbektaş", "Kozaklı"],
        "Niğde": ["Merkez", "Bor", "Çamardı", "Ulukışla"],
        "Ordu": ["Merkez", "Akkuş", "Altınordu", "Aybastı", "Fatsa", "Gölköy", "Gülyalı", "Gürgentepe", "İkizce", "Korgan", "Kumru", "Mesudiye", "Perşembe", "Ulubey", "Ünye"],
        "Osmaniye": ["Merkez", "Bahçe", "Kadirli", "Sumbas", "Toprakkale"],
        "Rize": ["Merkez", "Ardeşen", "Çamlıhemşin", "Çayeli", "Fındıklı", "İkizdere", "Kalkandere", "Pazar"],
        "Sakarya": ["Adapazarı", "Akyazı", "Geyve", "Hendek", "Karasu", "Kaynarca", "Sapanca", "Serdivan", "Söğütlü", "Taraklı"],
        "Samsun": ["Atakum", "Canik", "İlkadım", "Bafra", "Çarşamba", "Havza", "Kavak", "Ladik", "Terme", "Vezirköprü", "Asarcık", "Salıpazarı", "Yakakent"],
        "Siirt": ["Merkez", "Baykan", "Eruh", "Kurtalan", "Pervari", "Şirvan"],
        "Sinop": ["Merkez", "Ayancık", "Boyabat", "Dikmen", "Durağan", "Erfelek", "Gerze", "Türkeli"],
        "Sivas": ["Merkez", "Divriği", "Gemerek", "Gürün", "Hafik", "İmranlı", "Kangal", "Koyulhisar", "Suşehri", "Şarkışla", "Yıldızeli", "Zara"],
        "Şanlıurfa": ["Merkez", "Eyyübiye", "Haliliye", "Karaköprü", "Siverek", "Birecik", "Bozova", "Ceylanpınar", "Halfeti", "Hilvan", "Suruç", "Viranşehir"],
        "Şırnak": ["Merkez", "Beytüşşebap", "Cizre", "Güçlükonak", "İdil", "Silopi", "Uludere"],
        "Tekirdağ": ["Merkez", "Çerkezköy", "Çorlu", "Ergene", "Hayrabolu", "Malkara", "Muratlı", "Saray", "Süleymanpaşa"],
        "Tokat": ["Merkez", "Almus", "Artova", "Başçiftlik", "Erbaa", "Niksar", "Reşadiye", "Sulusaray", "Turhal", "Zile"],
        "Trabzon": ["Merkez", "Akçaabat", "Araklı", "Arsin", "Çarşıbaşı", "Çaykara", "Dernekpazarı", "Düzköy", "Hayrat", "Köprübaşı", "Maçka", "Of", "Ortahisar", "Sürmene", "Şalpazarı", "Tonya", "Vakfıkebir", "Yomra"],
        "Tunceli": ["Merkez", "Çemişgezek", "Hozat", "Mazgirt", "Nazımiye", "Ovacık", "Pertek", "Pülümür"],
        "Uşak": ["Merkez", "Banaz", "Eşme", "Karahallı", "Sivaslı", "Ulubey"],
        "Van": ["Merkez", "Başkale", "Çaldıran", "Çatak", "Edremit", "Erciş", "Gevaş", "Gürpınar", "İpekyolu", "Muradiye", "Özalp", "Tuşba"],
        "Yalova": ["Merkez", "Altınova", "Armutlu", "Çınarcık", "Termal"],
        "Yozgat": ["Merkez", "Akdağmadeni", "Aydıncık", "Boğazlıyan", "Çayıralan", "Çekerek", "Kadışehri", "Saraykent", "Sorgun", "Şefaatli", "Yenifakılı"],
        "Zonguldak": ["Merkez", "Alaplı", "Çaycuma", "Devrek", "Ereğli", "Gökçebey"],
    ]
    
    @Published  var selectedCity: String = "İl"
    @Published  var selectedDistrict: String = ""
    @Published var personelTel: String = ""
    @Published var kurumsalTel : String = ""
    @Published var email: String = ""
    @Published var website: String = ""
    
    
    init() {
        email = AuthService.shared.getCurrentUser()?.email ?? "email bulunamadı"
    }
    
    
    func updateContactInfo(){
        
    }
    
    func loadContactInfo(){
        
        FirestoreService.shared.fetchAcademicianDocumentById(byEmail: AuthService.shared.getCurrentUser()?.email ?? "") { result in
            
            switch result {
            case .success(let documentID):
                
                FirestoreService.shared.fetchAcademicianInfo(byId: documentID) { result in
                    
                    switch result {
                    case .success(let info):
                        
                        self.selectedCity = info.il
                        self.selectedDistrict = info.ilce
                        self.personelTel = info.personelTel
                        self.kurumsalTel = info.kurumsalTel
                        self.website = info.webSite
                        
                    case .failure(_):
                        print("Hata : FetchAcademicianInfo LoadContact AcademicianInfo")

                    }
                    
                }
                
            case .failure(_):
                print("Hata : FetchAcademicianInfo LoadContact DocumentId")
            }
            
        }
        
    }
    
    
}
