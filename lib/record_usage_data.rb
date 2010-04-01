require File.expand_path("../gres_google_spreadsheets", __FILE__)

class RecordUsageData
  @@doc_key = "0AqrB9HpxNdkcdEVGY3p6MTRmTDZzdEVBZzBrS2RzUWc"
  GoogleSpreadsheets::Base.user = @@user = "dramamitarecord@gmail.com"
  GoogleSpreadsheets::Base.password = @@password = "sonicgarden2010"

  def self.post
    doc = GoogleSpreadsheets::Spreadsheet.find(@@doc_key)

    sheet = GoogleSpreadsheets::Worksheet.find(:first, :params => {
                                                 :document_id => doc.id,
                                                 :title => "summary",
                                                 :visibility  => 'private',
                                                 :projection  => 'full'
                                               })

    GoogleSpreadsheets::List.create(:document_id  => doc.id,
                                    :worksheet_id => sheet.id,
                                    :visibility   => 'private',
                                    :projection   => 'full',
                                    'gsx_users'    => User.count,
                                    'gsx_watches'   => Watch.count,
                                    'gsx_enviroment' => ::Rails.env,
                                    'gsx_date'    => Time.now.to_formatted_s(:db))
  end
end
