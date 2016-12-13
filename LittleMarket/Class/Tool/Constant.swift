//
//  Constant.swift
//  LittleMarket
//
//  Created by J on 16/9/20.
//  Copyright © 2016年 J. All rights reserved.
//

import UIKit
import Alamofire

let ScreenBounds = UIScreen.main.bounds
let ScreenWidth = ScreenBounds.width
let ScreenHeight = ScreenBounds.height

let BarHeight = UIApplication.shared.statusBarFrame.height

let Judge = OS.debug // 运行模式


enum OS{
    case test
    case debug
    case run
}

struct ArticleCagetory {
    static let categoryDict = [
        "archive": "历史精华",
        
    ]
}

struct CellReuseIdentifier {
    static let MyGrid = "MyGrid"
    static let FindGrid = "FindGrid"
    static let OtherGrid = "OtherGrid"
    
    static let UserInfo = "UserInfo"
    static let UserMenu = "UserMenu"
    static let UserGrid = "UserGrid"
    static let UserDetail = "UserDetail"
    
    
}

struct Magic {
    static let GridNum = 5
    static let reSize = CGSize(width: 400, height: 600)
    static let Appinfo = "...一个有趣的交易信息共享平台"
    static let AppDetail = "    欢迎您注册成为格子铺的用户!\n请仔细阅读下面的协议，只有接受协议才能继续进行注册。\n1． 服务条款的确认和接纳\n平台所提供的服务将按照有关章程、服务条款和操作规则严格执行。用户通过注册程序点击 我同意 按钮，即表示用户与平台达成协议并接受所有的服务条款。\n2. 用户同意：\n1)提供及时、详尽及准确的个人资料。\n2)不断更新注册资料，符合及时、详尽、准确的要求。所有原始键入的资料将引用为注册资料。\n3)用户同意遵守《中华人民共和国保守国家秘密法》、《中华人民共和国计算机信息系统安全保护条例》、《计算机软件保护条例》等有关计算机及互联网规定的法律和法规、实施办法。在任何情况下，平台合理地认为用户的行为可能违反上述法律、法规，珠海市科技创新公共服务平台可以在任何时候，不经事先通知终止向该用户提供服务。用户应了解国际互联网的无国界性，应特别注意遵守当地所有有关的法律和法规。\n3． 服务条款的修改\n平台会不定时地修改服务条款，服务条款一旦发生变动，将会在相关页面上提示修改内容。如果您同意改动，则再一次点击 我同意 按钮。如果您不接受，则及时取消您的用户使用服务资格。\n4． 服务修订\n平台保留随时修改或中断服务而不需知照用户的权利。平台行使修改或中断服务的权利，不需对用户或第三方负责。\n5． 用户隐私制度\n尊重用户个人隐私是平台的基本政策。平台不会公开、编辑或透露用户的注册信息，除非有法律许可要求，或平台在诚信的基础上认为透露这些信息在以下三种情况是必要的：\n1)遵守有关法律规定，遵从合法服务程序。\n2)保持维护珠海市科技创新公共服务平台的商标所有权。\n3)在紧急情况下竭力维护用户个人和社会大众的隐私安全。\n4)符合其他相关的要求。\n6． 用户的帐号，密码和安全性\n一旦注册成功成为平台用户，您将得到一个密码和帐号。如果您不保管好自己的帐号和密码安全，将对因此产生的后果负全部责任。另外，每个用户都要对其帐户中的所有活动和事件负全责。您可随时根据指示改变您的密码，也可以重开一个新帐户。用户同意若发现任何非法使用用户帐号或安全漏洞的情况，立即通知。\n7． 免责条款\n旨在建立一个公益性平台，所发布的信息虽经初步筛选，但不能保证其所述是完全真实可靠的，信息提供者应依法对其提供的信息承担全部责任。\n对任何在本平台发布信息或使用信息所带来的风险不承担任何责任。访问和使用本平台者应自行判断相关信息的准确性、完整性和合法性，并同意自行承担访问和使用相关信息可能出现的全部风险。对您使用平台、与本平台相关的任何内容、服务或其它链接至本平台的站点、内容均不作直接、间接、法定、约定的保证。\n无论在任何原因下（包括但不限于疏忽原因），对您或任何人通过使用本平台上的信息或由本平台链接的信息，或其他与本平台链接的网站信息所导致的损失或损害（包括直接、间接、特别或后果性的损失或损害，例如收入或利润之损失，电脑系统之损坏或数据丢失等后果），责任均由使用者自行承担（包括但不限于疏忽责任）。\n8． 有限责任\n平台对任何直接、间接、偶然、特殊及继起的损害不负责任。\n9． 不提供零售和商业性服务\n用户使用服务的权利是个人的。用户承诺不经平台同意，不能利用平台做其他商业用途。\n10． 用户责任\n用户单独承担传输内容的责任。用户必须遵循：\n1)从中国境内向外传输技术性资料时必须符合中国有关法规。\n2)使用平台服务不作非法用途。\n3)不干扰或混乱网络服务。\n4)不在论坛BBS或留言簿发表任何与政治相关的信息。\n5)遵守所有使用网站服务的网络协议、规定、程序和惯例。\n6)不得利用本站危害国家安全、泄露国家秘密，不得侵犯国家社会集体的和公民的合法权益。\n7)不得利用本站制作、复制和传播下列信息：1、煽动抗拒、破坏宪法和法律、行政法规实施的；\n2、煽动颠覆国家政权，推翻社会主义制度的；\n3、煽动分裂国家、破坏国家统一的；\n4、煽动民族仇恨、民族歧视，破坏民族团结的；\n5、捏造或者歪曲事实，散布谣言，扰乱社会秩序的；\n6、宣扬封建迷信、淫秽、色情、赌博、暴力、凶杀、恐怖、教唆犯罪的；\n7、公然侮辱他人或者捏造事实诽谤他人的，或者进行其他恶意攻击的；\n8、损害国家机关信誉的；\n9、其他违反宪法和法律行政法规的；\n10、进行商业广告行为的。\n用户不能传输任何教唆他人构成犯罪行为的资料；不能传输涉及国家安全的资料；不能传输任何不符合当地法规、国家法律和国际法律的资料。未经许可而非法进入其它电脑系统是禁止的。若用户的行为不符合以上的条款，平台将取消用户服务帐号。\n11． 平台内容的所有权\n格子铺平台定义的内容包括：文字、软件、声音、相片、录象、图表；在广告中全部内容；电子邮件的全部内容；格子铺为用户提供的商业信息。所有这些内容受版权、商标、标签和其它财产所有权法律的保护。所以，用户只能在格子铺和广告商授权下才能使用这些内容，而不能擅自复制、篡改这些内容、或创造与内容有关的派生产品。\n12． 解释权\n本注册协议的解释权归格子铺所有。如果其中有任何条款与国家的有关法律相抵触，则以国家法律的明文规定为准。"
    
    
}

struct API {
    static let APIHost = "http://localhost:3000/"
    static let UserAPI = API.APIHost + "users/"
    static let LoginAPI = API.UserAPI + "checkUser"
    static let FindUserAPI = API.UserAPI + "findUser"
    static let CheckUserAPI = API.UserAPI + "checkUserName"
    static let AddUserAPI = API.UserAPI + "addUser"
    static let EditUserAPI = API.UserAPI + "updateUser"
    
    
    
    static let ProductAPI = API.APIHost + "products/"
    static let UserGirdAPI = API.ProductAPI + "userProducts"
    static let OtherGirdAPI = API.ProductAPI + "sortProducts"
    static let DeleteGirdAPI = API.ProductAPI + "deleteProducts"
    static let AddGirdAPI = API.ProductAPI + "addProducts"
    static let JudgeGirdAPI = API.ProductAPI + "updateScore"
    
    
    static let SortAPI = API.APIHost + "sorts/"
    
    static let PicAPI = API.APIHost + "pic/"
    static let UploadPicAPI = API.PicAPI + "upload"
    
    
    
    
}
