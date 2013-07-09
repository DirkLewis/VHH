#pragma mark - Enums

#pragma mark - Networking
typedef enum{
    
    OperationStatusSuccess = 0,
    OperationStatusFailed = 1,
    OperationStatusFailedWithError = 3
}OperationStatusCode;

typedef enum {
    NetworkLoginAttemptStatusUnknown = 0,
    NetworkLoginAttemptStatusSuccess = 1,
    NetworkLoginAttemptStatusFail = 2,
    NetworkLoginAttemptStatusWarning = 3,
    NetworkLoginAttemptStatusInprogress = 4
}NetworkLoginAttemptStatus;

#pragma mark - Repository


#pragma mark - Image Editing enum

typedef enum  {
    brightness = 0,
    contrast = 1,
    saturation = 2,
    rotation = 3,
    exposure = 4
} ROImageControl;

#pragma mark - Logging enum

typedef enum{
    
    ROLogError = 0,
    ROLogWarning = 1,
    ROLogInformation = 2,
    ROLogVerbose = 3,
    ROLogPerformance = 4
    
} LoggingLevels;

#pragma mark Disciplines Enum
typedef enum  {
    /** None */
    RODisciplineNone = 0,
    /** Physical Therapy (PT) */
    RODisciplinePhysicalTherapy = 1,
    /** Occupational Therapy (OT) */
    RODisciplineOccupationalTherapy = 2,
    /** Speech Therapy (ST) */
    RODisciplineSpeechTherapy = 4
}RODisciplines;

#pragma mark Diagnosis Type Enum
typedef enum {
    /** None */
    RODiagnosisTypeNone = 0,
    /** Medical Diagnosis */
    RODiagnosisTypeMedical = 1,
    /** Treatkejt Diagnosis */
    RODiagnosisTypeTreatment = 2
    
}RODiagnosisTypes;

#pragma mark Error Codes Enum
/** I'm sorry, Dave. I'm afraid I can't do that. 
 Core Data Failure Codes: 9001 - 9999
 */
typedef enum {
    /** None */
    ROErrorCodeNone = 0,
    ///////////////////////////////////////
    // Core Data Failure Codes: 9001 - 9200
    /** Operation attempted on a case that is closed (has an end date) */
    ROErrorCodeInvalidOperationOnClosedCase = 9001,
    /** More than one treatment track opened for the same case and discipline */
    ROErrorCodeDuplicateTreatmentTrack = 9002,
    ///////////////////////////////////////
    // Method Argument Validation Failure Codes: 9201 - 9400
    /** Required argument was null */
    ROErrorCodeNullArgument = 9201,
    // Authorization Failure: 9401 - 9600
    /** Action requested is not authorized */
    RONotAuthorizedForAction = 9401
    
}ROErrorCodes;

typedef enum {
	RODocumentListFilterAllDocuments,
	RODocumentListFilterDueIncompleteRecentlyCompleted
}RODocumentListFilters;


#pragma mark -  Constants
#define kROBackgroundFacililtyRefresh 3.0
#define kROSQLDatetimeFormatWithOffset @"\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}\\s\\+\\d{4}"
#define kROSQLDatetimeFormatWithoutOffset @"\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}"
#define kRODatetimeSimpleFormat @"\\d{2}\\d{2}\\d{4}"
#define kROFacilityPatientRefreshMinutes 15

#define TEXT_COLOR	 [UIColor colorWithRed:87.0/255.0 green:108.0/255.0 blue:137.0/255.0 alpha:1.0]
#define FLIP_ANIMATION_DURATION 0.18f


#define kAlphabetIndexForTableIndex @"A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"

//extern NSString* const kTherapyTrackToPatientKeyPath;
//#define kTherapyTrackToPatientKeyPath @"therapyTrackToPatientCase.patientCaseToStay.stayToPatient"

#pragma mark - OLD Constants
/** Error domain used in application generated errors */
#define kROErrorDomain @"com.OptimaHCS.rehabOptimaMobile"

/** Selection Filter Types */
#define kRODocumentFilterSelectionType @"RODocumentFilterSelectionType"


/** DocumentListFilter Titles & Values */
#define kRODocumentFilterTitle @"Filter Documents"
#define kRODocumentListFilterAllDocuments @"All Documents"
#define kRODocumentListFilterDueIncompleteRecentlyCompleted @"Due, Incomplete, and Recently Completed"

/** Discipline Codes */

/** Physical Therapy Code (PT) */
#define kRODisciplineCodePhysicalTherapy @"PT"
#define kRODisciplineNamePhysicalTherapy @"Physical Therapy"

/** Occupational Therapy Code (OT) */
#define kRODisciplineCodeOccupationalTherapy @"OT"
#define kRODisciplineNameOccupationalTherapy @"Occupational Therapy"

/** Speech Therapy (ST) */
#define kRODisciplineCodeSpeechTherapy @"ST"
#define kRODisciplineNameSpeechTherapy @"Speech Therapy"

/** Payer Type Names */
#define kPayerNameMCA @"Medicare Part A"
#define kPayerNameMCB @"Medicare Part B"
#define kPayerNamePrivate @"Private"

/** Payer Type Codes */
#define kPayerTypeA @"MCA"
#define kPayerTypeB @"MCB"
#define kPayerTypeP @"PVT"

/** Document Label Date Format */

/** Document Types */
#define kDocumentTypeProgressReport @"Progress Report"
#define kDocumentTypeEvaluation @"Evaluation"
#define kDocumentTypeRecertification @"Recertification"
#define kDocumentTypeDischargeSummary @"Discharge Summary"
#define kDocumentTypeTEN @"TEN"

/** KeyDate Label Text for Document Types */
#define kLabelTextOfKeyDateForDocumentTypeProgressReport @"Certification Date:"
#define kLabelTextOfKeyDateForDocumentTypeEvaluation @"Recertification Date:"
#define kLabelTextOfKeyDateForDocumentTypeRecertification @"Start Date:"
#define kLabelTextOfKeyDateForDocumentTypeDischargeSummary @"Discharge Date:"
#define kLabelTextOfKeyDateForDocumentTypeTEN @"Encounter Date:"

/** Document Status */
#define kDocumentStatusInComplete @"Incomplete"
#define kDocumentStatusComplete @"Complete"
#define kDocumentStatusSigned @"Signed"
#define kDocumentStatusCoSign @"Co-sign"

/** Status Label Text for Document Status */
#define kLabelTextOfKeyDateForDocumentStatusInComplete @"Due on:"
#define kLabelTextOfKeyDateForDocumentStatusComplete @"Completed:"
#define kLabelTextOfKeyDateForDocumentStatusSigned @"Signed on:"
#define kLabelTextOfKeyDateForDocumentStatusCoSign @"Co-sign:"

#pragma mark - User Defaults
#define kUserDefaultsKeyLastLoggedInUserName @"lastUserName"


#pragma mark - Notifications

// Notification Names
#define kPatientCaseSelectedNotification @"PatientCaseSelectedNotification"
#define kDocumentSelectedNotification @"DocumentSelectedNotification"

// navigation data dictionary keys
#define kNavDictionaryKeyRepository @"repository"

#define kStateMachineTransitionHUDMessage_Starting @"..starting.."
#define kStateMachineTransitionHUDMessage_Done @"..done.."
#define kStateMachineTransitionHUDMessage_Network @"..network.."
#define kStateMachineTransitionHUDMessage_Error @"..error.."
#define kStateMachineTransitionHUDMessage_Processing @"..processing.."
