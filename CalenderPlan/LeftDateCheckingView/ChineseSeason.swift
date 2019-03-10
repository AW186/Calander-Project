//
//  ChineseSeason.swift
//  CalenderPlan
//
//  Created by Zihao Arthur Wang [STUDENT] on 3/6/19.
//  Copyright © 2019 Zihao Arthur Wang [STUDENT]. All rights reserved.
//

import Foundation
class ChineseSeason {
    class CValues {
        static let lichun: Double = 3.87
        static let yushui: Double = 18.73
        static let jingzhe: Double = 5.63
        static let chunfen: Double = 20.646
        static let qingming: Double = 4.81
        static let guyu: Double = 20.1
        static let lixia: Double = 5.52
        static let xiaoman: Double = 21.04
        static let mangzhong: Double = 5.678
        static let xiazhi: Double = 21.37
        static let xiaoshu: Double = 7.108
        static let dashu: Double = 22.83
        static let liqiu: Double = 7.5
        static let chushu: Double = 23.13
        static let bailu: Double = 7.646
        static let qiufen: Double = 23.042
        static let hanlu: Double = 8.318
        static let shuangjiang: Double = 23.438
        static let lidong: Double = 7.438
        static let xiaoxue: Double = 22.36
        static let daxue: Double = 7.18
        static let dongzhi: Double = 21.94
        static let xiaohan: Double = 5.4055
        static let dahan: Double = 20.12
    }
    class StrVal {
        static let lichun = "立\n春"
        static let yushui = "雨\n水"
        static let jingzhe = "惊\n蛰"
        static let chunfen = "春\n分"
        static let qingming = "清\n明"
        static let guyu = "谷\n雨"
        static let lixia = "立\n夏"
        static let xiaoman = "小\n满"
        static let mangzhong = "芒\n种"
        static let xiazhi = "夏\n至"
        static let xiaoshu = "小\n暑"
        static let dashu = "大\n暑"
        static let liqiu = "立\n秋"
        static let chushu = "处\n暑"
        static let bailu = "白\n露"
        static let qiufen = "秋\n分"
        static let hanlu = "寒\n露"
        static let shuangjiang = "霜\n降"
        static let lidong = "立\n冬"
        static let xiaoxue = "小\n雪"
        static let daxue = "大\n雪"
        static let dongzhi = "冬\n至"
        static let xiaohan = "小\n寒"
        static let dahan = "大\n寒"
    }
    static func calcDate(season: Double) -> Int {
        let format = DateFormatter()
        format.dateFormat = "yy"
        let year = Double.init(format.string(from: NSDate() as Date))
        return Int(year!*0.2422+season-(year!-1)/4)
    }
    static private func getSeasonVerticleStringMonthly(opt1: String, opt2: String, opt3: String, seperator1: Int, seperator2: Int) -> String {
        let format = DateFormatter()
        format.dateFormat = "dd"
        let day = Int.init(format.string(from: NSDate() as Date))
        return day! < seperator1 ? opt1 : (day! < seperator2 ? opt2 : opt3)
    }
    static func getSeasonVerticleString() -> String {
        let format = DateFormatter()
        format.dateFormat = "MM"
        let month = Int.init(format.string(from: NSDate() as Date))
        switch month {
        case 2:
            let sep1 = calcDate(season: CValues.lichun)
            let sep2 = calcDate(season: CValues.yushui)
            return getSeasonVerticleStringMonthly(opt1: StrVal.dahan, opt2: StrVal.lichun, opt3: StrVal.yushui, seperator1: sep1, seperator2: sep2)
        case 3:
            let sep1 = calcDate(season: CValues.jingzhe)
            let sep2 = calcDate(season: CValues.chunfen)
            return getSeasonVerticleStringMonthly(opt1: StrVal.yushui, opt2: StrVal.jingzhe, opt3: StrVal.chunfen, seperator1: sep1, seperator2: sep2)
        case 4:
            let sep1 = calcDate(season: CValues.qingming)
            let sep2 = calcDate(season: CValues.guyu)
            return getSeasonVerticleStringMonthly(opt1: StrVal.chunfen, opt2: StrVal.qingming, opt3: StrVal.guyu, seperator1: sep1, seperator2: sep2)
        case 5:
            let sep1 = calcDate(season: CValues.lixia)
            let sep2 = calcDate(season: CValues.xiaoman)
            return getSeasonVerticleStringMonthly(opt1: StrVal.guyu, opt2: StrVal.lixia, opt3: StrVal.xiaoman, seperator1: sep1, seperator2: sep2)
        case 6:
            let sep1 = calcDate(season: CValues.mangzhong)
            let sep2 = calcDate(season: CValues.xiazhi)
            return getSeasonVerticleStringMonthly(opt1: StrVal.xiaoman, opt2: StrVal.mangzhong, opt3: StrVal.xiazhi, seperator1: sep1, seperator2: sep2)
        case 7:
            let sep1 = calcDate(season: CValues.xiaoshu)
            let sep2 = calcDate(season: CValues.dashu)
            return getSeasonVerticleStringMonthly(opt1: StrVal.xiazhi, opt2: StrVal.xiaoshu, opt3: StrVal.dashu, seperator1: sep1, seperator2: sep2)
        case 8:
            let sep1 = calcDate(season: CValues.liqiu)
            let sep2 = calcDate(season: CValues.chushu)
            return getSeasonVerticleStringMonthly(opt1: StrVal.dashu, opt2: StrVal.liqiu, opt3: StrVal.chushu, seperator1: sep1, seperator2: sep2)
        case 9:
            let sep1 = calcDate(season: CValues.bailu)
            let sep2 = calcDate(season: CValues.qiufen)
            return getSeasonVerticleStringMonthly(opt1: StrVal.chushu, opt2: StrVal.bailu, opt3: StrVal.qiufen, seperator1: sep1, seperator2: sep2)
        case 10:
            let sep1 = calcDate(season: CValues.hanlu)
            let sep2 = calcDate(season: CValues.shuangjiang)
            return getSeasonVerticleStringMonthly(opt1: StrVal.qiufen, opt2: StrVal.hanlu, opt3: StrVal.shuangjiang, seperator1: sep1, seperator2: sep2)
        case 11:
            let sep1 = calcDate(season: CValues.lidong)
            let sep2 = calcDate(season: CValues.xiaoxue)
            return getSeasonVerticleStringMonthly(opt1: StrVal.shuangjiang, opt2: StrVal.lidong, opt3: StrVal.xiaoxue, seperator1: sep1, seperator2: sep2)
        case 12:
            let sep1 = calcDate(season: CValues.daxue)
            let sep2 = calcDate(season: CValues.dongzhi)
            return getSeasonVerticleStringMonthly(opt1: StrVal.xiaoxue, opt2: StrVal.daxue, opt3: StrVal.dongzhi, seperator1: sep1, seperator2: sep2)
        case 1:
            let sep1 = calcDate(season: CValues.xiaohan)
            let sep2 = calcDate(season: CValues.dahan)
            return getSeasonVerticleStringMonthly(opt1: StrVal.dongzhi, opt2: StrVal.xiaohan, opt3: StrVal.dahan, seperator1: sep1, seperator2: sep2)
        default:
            return "节\n气"
        }
    }
}
