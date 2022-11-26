import Foundation

enum MainEvents: String {
    // Note
    case createNote = "create_note"
    case editNote = "edit_note"
    case deleteNote = "delete_note"

    // Stats
    case selectTypeOfAverageStat = "select_type_of_average_stat"
    case changeStatGroupingType = "change_stat_grouping_type"
    case changeStatDateRange = "change_stat_date_range"
    case selectStatChartBar = "select_stat_chart_bar"

    // Diary
    case openNote = "open_note"

    // Tag groups
    case addTagGroup = "add_tag_group"
    case deleteTagGroup = "delete_tag_group"
    case reorderTagGroup = "reorder_tag_group"

    // Tags
    case addTag = "add_tag"
    case reorderTag = "reorder_tag"
    case deleteTag = "delete_tag"
    case hideTag
    case moveTag = "move_tag"

    // Screens
    case More = "open_more"
    case Diary = "open_diary"
    case DetailNote = "open_detail_note"
    case NewNote = "open_new_note"
    case Statistics = "open_statistics"
    case EditTagGroup = "open_edit_tag_group"
    case EditNote = "open_edit_note"
    case EditTagGroups = "open_edit_tag_groups"

    // Onboardings
    case earlyOnboardingExit = "onboarding_early_exit"
    case numberOfSlideWhenEarlyExit = "number_of_slide_when_early_exit" // parameter
    case onboardingFinished = "onboarding_finished"

    // Backup
    case Backup = "open_backup"
    case successBackupInfoUpdate = "success_backup_info_update"
    case successBackup = "success_backup"
    case successRestore = "success_restore"
    case successBackupDeletion = "success_backup_deletion"
    case initiateBackupUpdate = "initiate_backup_update"
    case backupError = "backup_error" // as param pass error text
}
