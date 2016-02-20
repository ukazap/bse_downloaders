#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'fileutils'

folder_simpan = "downloads".gsub(/\/$/, "")
awal_url = "http://bse.kemdikbud.go.id/buku/bukusmp"
bagian = {
  :kelas7 => ["Bahasa-Indonesia", "Bahasa-Inggris", "Ilmu-Pengetahuan-Alam", "Ilmu-Pengetahuan-Sosial", "Keterampilan-dan-Kesenian", "Matematika", "Penjasorkes", "PKn", "TIK"],
  :kelas8 => ["Bahasa-Indonesia", "Bahasa-Inggris", "Ilmu-Pengetahuan-Alam", "Ilmu-Pengetahuan-Sosial", "Matematika", "Penjasorkes", "PKn", "TIK"],
  :kelas9 => ["Bahasa-Indonesia", "Bahasa-Inggris", "Ilmu-Pengetahuan-Alam", "Ilmu-Pengetahuan-Sosial", "Matematika", "Penjasorkes", "PKn", "TIK"]
}

bagian.each do |kelas, daftar_matpel|
  daftar_matpel.each do |matpel|
    puts "MULAI #{kelas}: #{matpel}\n\n"

    offset = 0

    loop do
      doc = Nokogiri::HTML(open "#{awal_url}/#{kelas}/#{matpel}/#{offset}")
      links = doc.css "td#BukuJudul a"

      break if links.count.zero?

      links.each do |link|
        id_buku = link[:href].split("/").last
        judul_buku = link.content
        link_unduh = "http://bse.kemdikbud.go.id/download/fullbook/#{id_buku}"
        save_as = "#{folder_simpan}/#{kelas}/#{matpel}/#{judul_buku} (#{id_buku}).pdf"
        
        unless File.exist? save_as
          FileUtils.mkdir_p "#{folder_simpan}/#{kelas}/#{matpel}"
          system "wget -O \"#{save_as}\" #{link_unduh}"
        else
          puts "SKIP #{save_as}"
        end

        File.rename(save_as, save_as.gsub(".pdf", ".txt")) if File.size(save_as) == 85
      end

      offset += 5
    end
  end
end