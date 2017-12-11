xml.instruct! :xml, version: 1.0

xml.browserconfig do
  xml.msapplication do
    xml.tile do
      xml.square70x70logo src: asset_path('meta/mstile-70x70.png')
      xml.square150x150logo src: asset_path('meta/mstile-150x150.png')
      xml.wide310x150logo src: asset_path('meta/mstile-310x150.png')
      xml.square310x310logo src: asset_path('meta/mstile-310x310.png')
      xml.TileColor '#d6d7d9'
    end
  end
end
