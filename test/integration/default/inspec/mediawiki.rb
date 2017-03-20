describe 'Mediawiki Setup' do
  mediawiki_path = '/var/www/html/mediawiki'

  it 'mediawiki installed' do
    expect(file(mediawiki_path)).to be_directory
    expect(file(mediawiki_path)).to be_owned_by('nginx')
    expect(file(mediawiki_path)).to be_grouped_into('nginx')
  end

  it 'has /var/log/mediawiki' do
    expect(file('/var/log/mediawiki')).to be_directory
    expect(file('/var/log/mediawiki')).to be_owned_by('nginx')
    expect(file('/var/log/mediawiki')).to be_grouped_into('nginx')
  end

  it 'has LocalSettings.php' do
    expect(file("#{mediawiki_path}/LocalSettings.php")).to exist
  end

  it 'mediawiki v1.28' do
    expect(file("#{mediawiki_path}/RELEASE-NOTES-1.28")).to exist
  end

  extension_list = %w(
    AntiBot
    AntiSpoof
    AutoSitemap
    Cite
    ConfirmEdit
    Gadgets
    googleAnalytics
    HideNamespace
    ImageMap
    InputBox
    Interwiki
    LocalisationUpdate
    Mantle
    MobileFrontend
    MultiBoilerplate
    News
    Nuke
    ParserFunctions
    PdfHandler
    Poem
    Renameuser
    ReplaceText
    Scribunto
    SimpleAntiSpam
    SpamBlacklist
    SyntaxHighlight_GeSHi
    TitleBlacklist
    UploadWizard
    Widgets
    WikiEditor
    YouTube
  )

  it 'extensions list' do
    extension_list.each do |extension|
      expect(file("#{mediawiki_path}/extensions/#{extension}")).to be_directory
    end
  end

  it 'has vector skin' do
    expect(file("#{mediawiki_path}/skins/Vector")).to be_directory
  end

  it 'has vendor' do
    expect(file("#{mediawiki_path}/vendor")).to be_directory
  end

  it 'has favicon symlink' do
    expect(file("#{mediawiki_path}/favicon.ico")).to be_symlink
  end

  it 'has sitemap.xml symlink' do
    expect(file("#{mediawiki_path}/sitemap.xml")).to be_symlink
  end

  it 'has logos' do
    expect(file("#{mediawiki_path}/uploads/desktop_logo.png")).to exist
    expect(file("#{mediawiki_path}/uploads/mobile_logo.png")).to exist
  end
end
