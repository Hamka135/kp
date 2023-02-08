-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 08 Feb 2023 pada 15.27
-- Versi server: 10.4.25-MariaDB
-- Versi PHP: 8.0.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `data_barang`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `IdBrg` char(8) NOT NULL,
  `NamaBarang` varchar(20) NOT NULL,
  `Stok` int(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`IdBrg`, `NamaBarang`, `Stok`) VALUES
('BRG001', 'Barang 1', 22),
('BRG002', 'Barang 2', 196),
('BRG003', 'Barang 3', 200),
('BRG004', 'Mouse', 8),
('BRG005', 'Kertas HVS A4', 12),
('BRG006', 'printer', 5);

-- --------------------------------------------------------

--
-- Struktur dari tabel `brg_keluar`
--

CREATE TABLE `brg_keluar` (
  `IdBKeluar` char(8) NOT NULL,
  `IdBrg` char(8) NOT NULL,
  `NamaBarang` varchar(20) NOT NULL,
  `NamaCostumer` varchar(25) NOT NULL,
  `Jumlah` int(12) NOT NULL,
  `Tanggal` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `brg_keluar`
--

INSERT INTO `brg_keluar` (`IdBKeluar`, `IdBrg`, `NamaBarang`, `NamaCostumer`, `Jumlah`, `Tanggal`) VALUES
('BK001', 'BRG001', 'Barang 1', 'Toki', 20, '17/12/2022'),
('BK002', 'BRG002', 'Barang 2', 'Chairul', 2, '1/29/2023'),
('BK003', 'BRG002', 'Barang 2', 'Mori', 3, '1/29/2023');

--
-- Trigger `brg_keluar`
--
DELIMITER $$
CREATE TRIGGER `delete_keluar` AFTER DELETE ON `brg_keluar` FOR EACH ROW BEGIN
    UPDATE barang SET Stok = Stok + OLD.Jumlah
    WHERE IdBrg = OLD.IdBrg;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `t_keluar` AFTER INSERT ON `brg_keluar` FOR EACH ROW BEGIN
    UPDATE barang SET Stok = Stok - NEW.Jumlah
    WHERE IdBrg = NEW.IdBrg;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `up_keluar` AFTER UPDATE ON `brg_keluar` FOR EACH ROW BEGIN
    UPDATE barang SET Stok = (Stok + OLD.Jumlah)-NEW.Jumlah
    WHERE IdBrg = NEW.IdBrg;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `brg_masuk`
--

CREATE TABLE `brg_masuk` (
  `IdBMasuk` char(8) NOT NULL,
  `IdBrg` char(8) NOT NULL,
  `NamaBarang` varchar(20) NOT NULL,
  `NamaSupplier` varchar(25) NOT NULL,
  `Jumlah` int(12) NOT NULL,
  `Tanggal` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `brg_masuk`
--

INSERT INTO `brg_masuk` (`IdBMasuk`, `IdBrg`, `NamaBarang`, `NamaSupplier`, `Jumlah`, `Tanggal`) VALUES
('BM001', 'BRG001', 'Barang 1', 'Hamka', 20, '08/07/2022'),
('BM002', 'BRG002', 'Barang 2', 'Naufal', 1, '1/29/2023'),
('BM003', 'BRG004', 'Mouse', 'Hamka', 4, '1/29/2023'),
('BM004', 'BRG005', 'Kertas HVS A4', 'PT Sinar Sharinggan', 7, '2/7/2023'),
('BM005', 'BRG006', 'printer', 'PT Sinar Sharinggan', 5, '2/7/2023');

--
-- Trigger `brg_masuk`
--
DELIMITER $$
CREATE TRIGGER `delete_masuk` AFTER DELETE ON `brg_masuk` FOR EACH ROW BEGIN 
    UPDATE barang SET Stok = Stok - OLD.Jumlah
    WHERE IdBrg = OLD.IdBrg;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `t_masuk` AFTER INSERT ON `brg_masuk` FOR EACH ROW BEGIN
    UPDATE barang SET Stok = Stok + NEW.Jumlah
    WHERE IdBrg = NEW.IdBrg;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `up_masuk` AFTER UPDATE ON `brg_masuk` FOR EACH ROW BEGIN
    UPDATE barang SET Stok = (Stok + NEW.Jumlah)-OLD.Jumlah
    WHERE IdBrg = NEW.IdBrg;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `login`
--

CREATE TABLE `login` (
  `userId` char(8) NOT NULL,
  `username` varchar(30) NOT NULL,
  `Level` varchar(11) NOT NULL,
  `password` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `login`
--

INSERT INTO `login` (`userId`, `username`, `Level`, `password`) VALUES
('USR001', 'hamka', 'Admin', 'a'),
('USR002', 'batara', 'Karyawan', 'a');

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE `supplier` (
  `IdSupplier` char(8) NOT NULL,
  `Namasupplier` varchar(30) NOT NULL,
  `Kontak` varchar(13) NOT NULL,
  `Alamat` varchar(25) NOT NULL,
  `Kota` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`IdSupplier`, `Namasupplier`, `Kontak`, `Alamat`, `Kota`) VALUES
('SPL001', 'PT Sinar Sharinggan', '6287654321', 'JL.Gagak ', 'Jatibening'),
('SPL002', 'Naufal', '0494847464353', 'Jl.Cemara', 'Bogor');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`IdBrg`);

--
-- Indeks untuk tabel `brg_keluar`
--
ALTER TABLE `brg_keluar`
  ADD PRIMARY KEY (`IdBKeluar`),
  ADD KEY `IdBrg` (`IdBrg`);

--
-- Indeks untuk tabel `brg_masuk`
--
ALTER TABLE `brg_masuk`
  ADD PRIMARY KEY (`IdBMasuk`),
  ADD KEY `IdBrg` (`IdBrg`);

--
-- Indeks untuk tabel `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`userId`);

--
-- Indeks untuk tabel `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`IdSupplier`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `brg_keluar`
--
ALTER TABLE `brg_keluar`
  ADD CONSTRAINT `brg_keluar_ibfk_1` FOREIGN KEY (`IdBrg`) REFERENCES `barang` (`IdBrg`);

--
-- Ketidakleluasaan untuk tabel `brg_masuk`
--
ALTER TABLE `brg_masuk`
  ADD CONSTRAINT `brg_masuk_ibfk_1` FOREIGN KEY (`IdBrg`) REFERENCES `barang` (`IdBrg`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
