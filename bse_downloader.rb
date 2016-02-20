#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'fileutils'

url_awal = "http://bse.kemdikbud.go.id/buku/bukusmp"
bagian = {
  :kelas7 => ["Bahasa-Indonesia", "Bahasa-Inggris", "Ilmu-Pengetahuan-Alam", "Ilmu-Pengetahuan-Sosial", "Keterampilan-dan-Kesenian", "Matematika", "Penjasorkes", "PKn", "TIK"],
  :kelas8 => ["Bahasa-Indonesia", "Bahasa-Inggris", "Ilmu-Pengetahuan-Alam", "Ilmu-Pengetahuan-Sosial", "Matematika", "Penjasorkes", "PKn", "TIK"],
  :kelas9 => ["Bahasa-Indonesia", "Bahasa-Inggris", "Ilmu-Pengetahuan-Alam", "Ilmu-Pengetahuan-Sosial", "Matematika", "Penjasorkes", "PKn", "TIK"]
}

bagian.each do |kelas, daftar_matpel|
  daftar_matpel.each do |matpel|
    puts "=== #{kelas}: #{matpel} ===\n\n"
    offset = 0
    loop do
      doc = Nokogiri::HTML(open "#{url_awal}/#{kelas}/#{matpel}/#{offset}")
      links = doc.css("td#BukuJudul a")

      break if links.count.zero?

      links.each do |link|
        id_buku = link[:href].split("/").last
        judul_buku = link.content
        dl_link = "http://bse.kemdikbud.go.id/download/fullbook/#{id_buku}"
        dl_file = "downloads/#{kelas}/#{matpel}/#{judul_buku} (#{id_buku}).pdf"
        unless File.exist? dl_file
          FileUtils.mkdir_p "downloads/#{kelas}/#{matpel}"
          system "wget -O \"#{dl_file}\" #{dl_link}"
        else
          puts "SKIP #{dl_file}"
        end
      end
      offset += 5
    end
  end
end