// # Introduction

// The Preventive Care logic library supports decision-making on preventive care screening for Prostate Cancer.

library ProstateCancerSummary version '1.0.0'

// # Data model #

using FHIR version '4.0.1'

// # Referenced libraries #

// The FHIRHelpers library provides common functions for simplifying interaction w/ the FHIR R4 data model.
include FHIRHelpers version '4.0.1' called FHIRHelpers
// The CDS Connect Commons library provides functions representing commonly used CDS logic and patterns.
include CDSConnectCommons version '1.0.0' called C3F
// The PreventiveCareConcepts library provides terminology concepts used to identify data elements throughout the artifact.
include PreventiveCareConcepts version '1.0.0' called PCC
// The PreventiveCareData library provides common data retrieval logic for preventive care guidelines.
include PreventiveCareData version '1.0.0' called Data
// Common expressions and functions for summaries.
include PreventiveCareSummary version '1.0.0' called Summary
// Prostate cancer screening logic from USPSTF
include ProstateCancerScreening version '1.0.0' called PCS

// # CDS logic #

context Patient

define ScreeningSummary: {
  alertPatient: PCS."Needs Prostate Cancer Screening",
  recommendScreening: PCS."Needs Prostate Cancer Screening",
  name: 'Prostate Cancer Screening',
  title: 'Decide If Prostate Cancer Screening Is Right for You',
  information: "Screening Information Statement",
  decision: "Patient Decision",
  screeningChoice: "Is Screening Right for You?",
  questionnaire: 'mpc-prostate-cancer'
}

define "Screening Information Statement":
  (List{
    if PCS."No PSA test results"
      then 'You have never had a PSA test'
    else
      'Your PSA value was ' + ToString(PCS."Last PSA value") + ' on ' + ToString(PCS."Last PSA date")null
  }) Text where Text is not null

define "Patient Decision":
  'Screening for prostate cancer has both potential benefits and harms. Whether you should be screened for prostate cancer is a personal decision. It depends on how worried you are about prostate cancer versus how worried you are about the harms of testing.'

define "Is Screening Right for You?":
  'Guidelines say that men aged 55 to 69 years should talk with their doctor every 2 years and decide if they want to be screened.'

/*
 * The following expressions are not currently used.
 */

// # Next Steps #

define "Next Step 1":
  'Talk with ' + Data."Patient PCP name" + ' about whether you need another PSA test now.'

define "Next Step 2":
  'When you turn 55, learn about prostate cancer screening and think about whether you want to be tested.'

define "Next Step 3":
  'Decide with ' + Data."Patient PCP name" + ' whether a PSA test is right for you.'

define "Next Step 4":
  'Learn about PSA testing and think about whether you want another test after ' + ToString(PCS."Last PSA date" + 2 years)

// # Text Variables #

define "PC Status":
  if PCS."Has prostate cancer Hx"
    then Data."Patient PCP name" + ' says that you have a history of prostate cancer'
  else if PCS."Has high PSA value"
    then 'you said that you have a history of high PSA value (PSA value higher than 4.0)'
  else
    null

define "MI PSA Date 1":
  if PCS."Has PSA within one year"
    then Data."Patient PCP name" + '\'s record states that you last had a PSA test on ' + ToString(PCS."Last PSA date") + '.  You may be up-to-date with your PSA test.'
  else if PCS."Has PSA test"
    then Data."Patient PCP name" + '\'s record states that you last had a PSA test on ' + ToString(PCS."Last PSA date") + '.  You may be due for another PSA test.'
  else Data."Patient PCP name" + ' does not have a record of when your last PSA was.'

define "PSA value 1":
  'Your last PSA value was ' + ToString(PCS."Last PSA value") + '. Generally, a PSA below 4 is considered good. Higher values may be, OK if they are not increasing over time.'

// # PSA risk statements #

// TODO handle unknown FH. Research negation of conditions and unknown.
define "PSA risk statement":
  if Data."Race is African American" and PCS."Has family history of prostate cancer"
    then 'You are African American and have a family history of prostate cancer.  This places you at higher risk for prostate cancer.'
  else if not Data."Race is African American" and PCS."Has family history of prostate cancer"
    then 'You have a family history of prostate cancer.  This places you at higher risk for prostate cancer.'
  else if Data."Race is African American" and not PCS."Has family history of prostate cancer"
    then 'You are African American.  This places you at higher risk for prostate cancer.'
  else if Data."Race is African American"
    then 'You are African American.  This places you at higher risk for prostate cancer.  You said you are unsure if you have a family history of prostate cancer.  If you do, this also places you at higher risk for prostate cancer.'
  else
    'You said you are unsure if you have a family history of prostate cancer.  If you do, this places you at higher risk for prostate cancer.'

// TODO handle unknown FH. Research negation of conditions and unknown.
define "PSA risk phrase":
  if Data."Race is African American" and PCS."Has family history of prostate cancer"
    then 'are African American and have a family history of prostate cancer'
  else if not Data."Race is African American" and PCS."Has family history of prostate cancer"
    then 'have a family history of prostate cancer'
  else if Data."Race is African American" and not PCS."Has family history of prostate cancer"
    then 'are African American'
  else if Data."Race is African American"
    then 'are African American and may have a family history of prostate cancer'
  else
    'may have a family history of prostate cancer'

// # Patient text blocks #

define "Need PSA statement":
  Data."Patient PCP name" + '\'s record says you last had a PSA test on ' + ToString(PCS."Last PSA date")
