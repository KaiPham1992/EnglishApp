//
//  LocalizableKey.swift
//  EnglishApp
//
//  Created by Kai Pham on 5/11/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation

struct LocalizableKey {
    // Menu
    static let MenuInfo = "MenuInfo"
    static let MenuTop = "MenuTop"
    static let MenuQA = "MenuQA"
    static let MenuLanguage = "MenuLanguage"
    static let MenuSaved = "MenuSaved"
    static let MenuHistory = "MenuHistory"
    static let MenuPrivacy = "MenuPrivacy"
    static let MenuChangePassword = "MenuChangePassword"
    static let MenuLogout = "MenuLogout"
    
    // Login Page
    static let LoginEmail = "LoginEmail"
    static let LoginEmailPlaceHolder = "LoginEmailPlaceHolder"
    static let LoginPassword = "LoginPassword"
    static let LoginButtonLogin = "LoginButtonLogin"
    static let LoginButtonSignUp = "LoginButtonSignUp"
    static let FBorGmail = "FBorGmail"
    static let ForgotPass = "ForgotPass"
    static let Register = "Register"
    static let NotYetAccount = "NotYetAccount"
    
    static let invalidLoginEmail = "invalidLoginEmail"
    static let invalidLoginPassword = "invalidLoginPassword"
    static let emptyLoginEmailPassword = "emptyLoginEmailPassword"
    static let passwordDifference = "passwordDifference"
    
    // Forgot password Page
    static let ForgotPasswordMessage = "ForgotPasswordMessage"
    static let SentEmail = "SentEmail"
    static let ForgotTitle = "ForgotTitle"
    
    // Change Language
    static let vietnamese = "vietnamese"
    static let english = "english"
    
    
    // profil
    static let DisplayName = "DisplayName"
    static let enterDisplayName = "enterDisplayName"
    static let TitleProfile = "TitleProfile"
    static let Location = "Location"
    static let CodeNumber = "CodeNumber"
    static let EditProfile = "EditProfile"
    static let titleSave = "titleSave"
    static let titleDiamon = "Kim cương"
    static let titleBee = "Hũ mật ong"
    
    // preview profile
    
    static let privateInfo = "privateInfo"
    static let privateHistory = "privateHistory"
    
    // Change pass word
    
    static let currentPassword = "currentPassword"
    static let currentPasswordLogin = "currentPasswordLogin"
    static let newPassword = "newPassword"
    static let reNewPassword = "reNewPassword"
    static let changePasssword = "changePasssword"
    static let changePassswordSuccess = "changePassswordSuccess"
    static let signUpSuccess = "signUpSuccess"
    static let editProfileSuccess = "editProfileSuccess"
    static let emptyCapcha = "emptyCapcha"
    
    static let popUpLogout = "popUpLogout"
    static let agree = "agree"
    static let cancel = "cancel"
    static let changePasswordSuccess = "changePasswordSuccess"
    static let popleaveHomeWork = "popleaveHomeWork"
    static let boxHoney = "boxHoney"
    static let titleHistoryNap = "titleHistoryNap"
    
    // QA
    
    static let whatQA = "whatQA"
    static let enterQA = "enterQA"
    static let messageQA = "messageQA"
    static let qAOlder = "qAOlder"
    static let titleQA = "titleQA"
    static let notEnoughHoney = "notEnoughHoney"
    static let deductFiveHoney = "deductFiveHoney"
    static let pleaseEnterQA = "pleaseEnterQA"
    static let pleaseEnter255Digit = "pleaseEnter255Digit"
    
    // Competition
    static let titleCompetition = "titleCompetition"
    static let conditionCompetition = "conditionCompetition"
    static let timeStart = "timeStart"
    static let countTeam = "countTeam"
    static let competition = "competition"
    
    static let selectTeamJoin = "selectTeamJoin"
    static let joinTeam = "joinTeam"
    static let team = "team"
    static let member = "member"

    // Detail team
    static let startAfter = "startAfter"
    static let explainConpetition = "explainConpetition"
    static let leaveTeam = "leaveTeam"
    static let createGroup = "createGroup"
    static let nameGroup = "nameGroup"
    static let enterNameGroup = "enterNameGroup"
    static let leaveTeamPopUp = "leaveTeamPopUp"
    static let verifyButton = "verifyButton"
    
    static let messageDailyMission = "messageDailyMission"
    static let dailyMissionTitle = "dailyMissionTitle"
    static let startMission = "startMission"
    
    
    // Report
    static let report = "report"
    static let description = "description"
    static let enterContent = "enterContent"

    static let search = "search"
    static let dictionaty = "dictionaty"
    static let vietnamese_to_english = "vietnamese_to_english"
    static let english_to_english = "english_to_english"
    static let english_to_vietnamese = "english_to_vietnamese"
    static let japanese_to_vietnamese = "japanese_to_vietnamese"
    static let addDictionary = "addDictionary"
    
    static let saved = "saved"
    static let grammar = "grammar"
    static let grammar_upper = "grammar_upper"
    static let vocabulary = "vocabulary"
    static let note = "note"
    static let writeNote = "write_note"
    static let please_enter_note = "please_enter_note"
    static let cofirm_delete = "cofirm_delete"
    
    //theory
    
    static let phrasal_verbs = "phrasal_verbs"
    static let phonetics = "phonetics"
    static let lesson = "lesson"
    static let recipe = "recipe"
    
    static let idiams = "Idioms"
    static let wordUsage = "word_usage"
    static let wordForm = "word_form"
    
    // Home
    static let homeDictionary = "homeDictionary"
    static let homeStore = "homeStore"
    static let homeMission = "homeMission"
    static let homeFindWork = "homeFindWork"
    static let actionRecently = "actionRecently"
    static let doneInputTest = "doneInputTest"
    
    // TABBAR
    static let tabbarHome = "tabbarHome"
    static let tabbarProgram = "tabbarProgram"
    static let tabbarHomeWork = "tabbarHomeWork"
    static let tabbarCompetition = "tabbarCompetition"
    
    // report popup
    static let reportTitlePopUp = "reportTitlePopUp"
    static let reportMessagePopUp = "reportMessagePopUp"
    static let reportButtonPopUp = "reportButtonPopUp"
    static let notEnoughBee = "notEnoughBee"
    static let notEnoughDiamon = "notEnoughDiamon"
    static let addBee = "addBee"
    static let ADDBEE = "ADDBEE"
    static let addDiamon = "addDiamon"
    

    // store
    static let studyPack = "studyPack"
    static let beePack = "beePack"
    static let titleStore = "titleStore"
    static let enterCode = "enterCode"
    static let send = "send"
    static let detail = "detail"
    static let upgrade = "upgrade"
    static let pleaseEnterCode = "pleaseEnterCode"
    static let notFoundCode = "notFoundCode"
    static let usedCode = "usedCode"
    static let exchangeGiftTitle = "exchangeGiftTitle"
    static let exchangeGiftSucess = "exchangeGiftSucess"
    static let exchangeTitle = "exchangeTitle"
    static let redeemSuccess = "redeemSuccess"
    static let upgradeSuccess = "upgradeSuccess"
    static let upgradeBeePack = "upgradeBeePack"
    static let notEnoughHoneyText = "notEnoughHoneyText"
    static let notEnoughDiamondText = "notEnoughDiamondText"

    //comment
    static let comment = "comment"
    static let point = "point"
    
    //exercise
    static let exercise = "exercise"
    static let practice = "practice"
    static let create_exercise = "create_exercise"
    static let level_exercise = "level_exercise"
    static let assign_exercise = "assign_exercise"
    static let name_exercise = "name_exercise"
    static let enter_name_exercise = "enter_name_exercise"
    static let choice_exercise = "choice_exercise"
    static let exercise_level = "exercise_level"
    static let history_exercise = "history_exercise"
    static let do_exercise = "do_exercise"
    static let word_form = "word_form"
    static let preposition = "preposition"
    static let rewriting = "rewriting"
    static let verb_form = "verb_form"
    static let listening = "listening"
    static let phrasal_verb = "phrasal_verb"
    static let cloze_test = "cloze_test"
    static let try_hard = "try_hard"
    static let task_every_date = "task_every_date"
    static let time_end = "time_end"
    static let see_more = "see_more"
    static let sentence = "sentence"
    static let next = "next"
    static let do_entrance = "do_entrance"
    
    
    
    //result
    static let rank = "rank"
    static let result = "result"
    static let result_team = "result_team"
    static let sum_point = "sum_point"
    static let time_do_exercise = "time_do_exercise"
    static let back_gome = "back_gome"
    static let result_competion = "result_competion"
    static let result_group = "result_group"
    static let see_explain = "see_explain"
    static let respond_question = "respond_question"
    static let explain_solution = "explain_solution"
    static let individual = "individual"
    static let action = "action"
    static let not_correct = "not_correct"
    static let see_result = "see_result"
    static let explain_question = "explain_question"
    static let confirm_back_result = "confirm_back_result"
    static let related_lesson = "related_lesson"
    
    //popup
    static let confirm = "confirm"
    static let update_account = "update_account"
    static let diamond = "diamond"
    static let money = "money"
    static let update = "update"
    
    static let enter_content = "enter_content"
    static let cancel_upper = "cancel_upper"
    static let complete_upper = "complete_upper"
    
    
    //month
    static let january = "January"
    static let february = "February"
    static let march = "March"
    static let april = "April"
    static let may = "May"
    static let june = "June"
    static let july = "July"
    static let august = "August"
    static let september = "September"
    static let october = "October"
    static let november = "November"
    static let december = "December"
    static let YEAR = "YEAR"
    
    //week
    static let su = "Su"
    static let mo = "Mo"
    static let tu = "Tu"
    static let we = "We"
    static let th = "Th"
    static let fr = "Fr"
    static let sa = "Sa"
    
    //hour
    static let hour = "hour"
    static let min = "min"
    static let second = "second"
    
    // Notificaiton
    static let titleNotification = "titleNotification"
    static let titleNotificationDetail = "titleNotificationDetail"
    
    // up grade
    static let requireUpGrade = "requireUpGrade"
    static let btnUpGrade = "btnUpGrade"
    static let levelUp = "levelUp"
    static let point_level = "point_level"
    
    static let changeLanguage = "changeLanguage"
    static let bxh = "bxh"
    
    
    //lesson
    
    static let simple_present = "simple_present"
    static let present_perfect = "present_perfect"
    static let present_countinous = "present_countinous"
    static let past_simple = "past_simple"
    static let theory = "theory"
    
    static let messagePackage = "messagePackage"
    static let find = "find"
    static let privacyAndPolicy = "PrivacyAndPolicy"
    
    static let pleaseEnterEmail = "pleaseEnterEmail"
    
    static let pleaseEnterDisplayName = "pleaseEnterDisplayName"
    static let pleaseEnterPassword = "pleaseEnterPassword"
    static let pleaseEnterCurrentPassword = "pleaseEnterCurrentPassword"
    static let pleaseEnterNewPassword = "pleaseEnterNewPassword"
    static let pleaseEnterRePassword = "pleaseEnterRePassword"
    static let pleaseTurnOnInternet = "pleaseTurnOnInternet"
    
    static let enterPassword = "enterPassword"
    static let enterRePassword = "enterRePassword"
    static let enterCaptcha = "enterCaptcha"
    static let boxHoneyTitle = "boxHoneyTitle"
    static let lbNoData = "lbNoData"
    
    //-- BXH
    static let all = "all"
    static let quater = "quater"
    static let BRONZE = "BRONZE"
    static let SILVER = "SILVER"
    static let GOLD = "GOLD"
    static let PLATINUM = "PLATINUM"
    static let MASTER = "MASTER"
    static let TOAA = "TOAA"
    static let TheOneAboveAll = "TheOneAboveAll"
    static let ALL = "ALL"
    
    //pop up
    static let getError = "getError"
    
    // find
    static let noResultFound = "noResultFound"
    static let feeFind = "feeFind"
    static let findExcersise = "findExcersise"
    
    // save
    static let done = "done"
    
    //add after
    
    static let rank_of_competition = "rank_of_competition"
    
    static let setting = "setting"
    static let start = "start"
    static let vocabularyDetail = "vocabularyDetail"
    static let deadline = "deadline"
    
    // pop up choose photo
    static let camera = "camera"
    static let library = "library"
    static let notAllowGifPhoto = "notAllowGifPhoto"
}
