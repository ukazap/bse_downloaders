#!/usr/bin/env ruby

require 'nokogiri'
require 'open-uri'
require 'fileutils'

folder_simpan = "downloads/sd".gsub(/\/$/, "")
awal_url = "http://bse.kemdikbud.go.id/buku/bukusd"

idem = ["Bahasa-Indonesia", "Ilmu-Pengetahuan-Alam", "Ilmu-Pengetahuan-Sosial", "Matematika", "PKn"]
bagian = {
  :kelas1 => idem,
  :kelas2 => idem,
  :kelas3 => idem,
  :kelas4 => idem,
  :kelas5 => idem,
  :kelas6 => idem,
}

bagian.each do |kelas, daftar_matpel|
  daftar_matpel.each do |matpel|
    puts "MULAI #{kelas}: #{matpel}\n\n"
    FileUtils.mkdir_p "#{folder_simpan}/#{kelas}/#{matpel}"

    offset = 0
    loop do
      doc = Nokogiri::HTML(open "#{awal_url}/#{kelas}/#{matpel}/#{offset}")
      links = doc.css "td#BukuJudul a"

      break if links.count.zero?

      links.each do |link|
        id_buku = link[:href].split("/").last
        judul_buku = link.content
        link_unduh = "http://bse.kemdikbud.go.id/download/fullbook/#{id_buku}"
        save_as = "#{folder_simpan}/#{kelas}/#{matpel}/#{judul_buku} (#{id_buku})"
        
        unless File.exist? save_as + ".pdf"
          system "wget -O \"#{save_as}\" #{link_unduh}"
        else
          puts "SKIP #{save_as}"
        end

        File.rename save_as, save_as + ((File.size(save_as) == 85)? ".txt" : ".pdf")
      end

      offset += 5
    end
  end
end