//
//  RequestViewModel.swift
//  USIApp
//
//  Created by Mustafa Ölmezses on 21.07.2025.
//

import Foundation

class RequestViewModel: ObservableObject {
    
    @Published var requests: [RequestModel] = [
        RequestModel(title: "Stajyer Talebi", description: "Yazılım departmanımıza 2 stajyer arıyoruz.", date: Date()),
        RequestModel(title: "Proje Ortaklığı", description: "Makine mühendisliği öğrencileriyle Ar-Ge projesi.", date: Date())
    ]

    @Published var showNewRequestSheet = false
    
    @Published var selectedCategories: [String] = []

    @Published var customCategoryInput: String = ""
    
    let categories: [String] = [
        "Yapay Zeka",
        "Makine Öğrenmesi",
        "Veri Bilimi",
        "Blokzincir",
        "Mobil Uygulama",
        "Web Uygulaması",
        "Siber Güvenlik",
        "Sağlık Teknolojileri",
        "Tarım Teknolojileri",
        "Enerji Sistemleri",
        "Yenilenebilir Enerji",
        "Elektrikli Araçlar",
        "IoT (Nesnelerin İnterneti)",
        "Endüstri 4.0",
        "Akıllı Şehirler",
        "Giyilebilir Teknolojiler",
        "E-Ticaret",
        "Fintech",
        "Biyoteknoloji",
        "Oyun Geliştirme",
        "Sanal Gerçeklik (VR)",
        "Artırılmış Gerçeklik (AR)",
        "Robotik",
        "3D Yazıcı Projeleri",
        "Gıda Teknolojileri",
        "Sosyal Medya Uygulamaları",
        "Eğitim Teknolojileri",
        "Ulaşım ve Lojistik",
        "Su ve Atık Yönetimi",
        "Akıllı Ev Sistemleri",
        "Uzaktan Eğitim",
        "Girişimcilik",
        "Sosyal Girişimcilik",
        "İleri Malzeme Teknolojisi",
        "Yeşil Teknolojiler",
        "Uzay Teknolojileri",
        "Dil İşleme (NLP)",
        "Otomasyon Sistemleri",
        "Yapay Organlar",
        "Yüz Tanıma Sistemleri",
        "Dijital Pazarlama",
        "Akıllı Tarım",
        "İnsansız Hava Araçları (İHA)",
        "Gömülü Sistemler",
        "Proje Yönetimi",
        "Veri Tabanı Sistemleri",
        "İş Zekası",
        "Karar Destek Sistemleri",
        "Sosyal Sorumluluk Projeleri"
    ]

    
}
