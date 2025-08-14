--
-- PostgreSQL database dump
--

-- Dumped from database version 17.5
-- Dumped by pg_dump version 17.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: enum_aktivitas_gerbang_kendaraans_buka_atau_tutup; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_aktivitas_gerbang_kendaraans_buka_atau_tutup AS ENUM (
    'Buka',
    'Tutup',
    'Terbuka',
    'Tertutup'
);


ALTER TYPE public.enum_aktivitas_gerbang_kendaraans_buka_atau_tutup OWNER TO postgres;

--
-- Name: enum_aktivitas_gerbang_kendaraans_lokasi_gerbang; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_aktivitas_gerbang_kendaraans_lokasi_gerbang AS ENUM (
    'Masuk',
    'Keluar'
);


ALTER TYPE public.enum_aktivitas_gerbang_kendaraans_lokasi_gerbang OWNER TO postgres;

--
-- Name: enum_aktivitas_gerbang_kendaraans_status_palang; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_aktivitas_gerbang_kendaraans_status_palang AS ENUM (
    'Sukses',
    'Gagal',
    'Gagal (Sensor)'
);


ALTER TYPE public.enum_aktivitas_gerbang_kendaraans_status_palang OWNER TO postgres;

--
-- Name: enum_aktivitas_gerbang_kendaraans_tipe_gerbang; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_aktivitas_gerbang_kendaraans_tipe_gerbang AS ENUM (
    'In',
    'Out'
);


ALTER TYPE public.enum_aktivitas_gerbang_kendaraans_tipe_gerbang OWNER TO postgres;

--
-- Name: enum_dashboard_pendapatans_periode; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_dashboard_pendapatans_periode AS ENUM (
    'hari_ini',
    'minggu_ini',
    'bulan_ini',
    'tahun_ini'
);


ALTER TYPE public.enum_dashboard_pendapatans_periode OWNER TO postgres;

--
-- Name: enum_data_vouchers_model_bayar; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_data_vouchers_model_bayar AS ENUM (
    'Check In',
    'Check Out'
);


ALTER TYPE public.enum_data_vouchers_model_bayar OWNER TO postgres;

--
-- Name: enum_data_vouchers_verifikasi; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_data_vouchers_verifikasi AS ENUM (
    'Tiket',
    'Nopol'
);


ALTER TYPE public.enum_data_vouchers_verifikasi OWNER TO postgres;

--
-- Name: enum_permasalahan_atau_perbaikans_kategori_permasalahan; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_permasalahan_atau_perbaikans_kategori_permasalahan AS ENUM (
    'Hardware/Alat',
    'Sistem',
    'SDM',
    'Operasional',
    'Lain-lain'
);


ALTER TYPE public.enum_permasalahan_atau_perbaikans_kategori_permasalahan OWNER TO postgres;

--
-- Name: enum_permasalahan_atau_perbaikans_status_perbaikan; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_permasalahan_atau_perbaikans_status_perbaikan AS ENUM (
    'Pending',
    'On Progress',
    'Done'
);


ALTER TYPE public.enum_permasalahan_atau_perbaikans_status_perbaikan OWNER TO postgres;

--
-- Name: enum_permasalahan_atau_perbaikans_status_permasalahan; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_permasalahan_atau_perbaikans_status_permasalahan AS ENUM (
    'Pending',
    'On Progress',
    'Done'
);


ALTER TYPE public.enum_permasalahan_atau_perbaikans_status_permasalahan OWNER TO postgres;

--
-- Name: enum_perusahaans_jenis_perusahaan; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_perusahaans_jenis_perusahaan AS ENUM (
    'Pemilik Gedung',
    'Tenant',
    'Developer'
);


ALTER TYPE public.enum_perusahaans_jenis_perusahaan OWNER TO postgres;

--
-- Name: enum_pos_tipe_kendaraan; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_pos_tipe_kendaraan AS ENUM (
    'Mobil',
    'Motor',
    'All'
);


ALTER TYPE public.enum_pos_tipe_kendaraan OWNER TO postgres;

--
-- Name: enum_pos_tipe_pos; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_pos_tipe_pos AS ENUM (
    'In',
    'Out'
);


ALTER TYPE public.enum_pos_tipe_pos OWNER TO postgres;

--
-- Name: enum_produk_vouchers_metode_verifikasi; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_produk_vouchers_metode_verifikasi AS ENUM (
    'Tiket',
    'Nopol'
);


ALTER TYPE public.enum_produk_vouchers_metode_verifikasi OWNER TO postgres;

--
-- Name: enum_produk_vouchers_model_pembayaran; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_produk_vouchers_model_pembayaran AS ENUM (
    'Check In',
    'Check Out'
);


ALTER TYPE public.enum_produk_vouchers_model_pembayaran OWNER TO postgres;

--
-- Name: enum_users_jenis_kelamin; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_jenis_kelamin AS ENUM (
    'Laki-laki',
    'Perempuan'
);


ALTER TYPE public.enum_users_jenis_kelamin OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: aktivitas_gerbang_kendaraans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.aktivitas_gerbang_kendaraans (
    id integer NOT NULL,
    tiket character varying(255),
    plat_nomor character varying(255),
    kendaraan_id integer,
    waktu time without time zone,
    lokasi_gerbang public.enum_aktivitas_gerbang_kendaraans_lokasi_gerbang,
    buka_atau_tutup public.enum_aktivitas_gerbang_kendaraans_buka_atau_tutup,
    petugas_id integer,
    status_palang public.enum_aktivitas_gerbang_kendaraans_status_palang,
    tipe_gerbang public.enum_aktivitas_gerbang_kendaraans_tipe_gerbang,
    data_member_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.aktivitas_gerbang_kendaraans OWNER TO postgres;

--
-- Name: aktivitas_gerbang_kendaraans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.aktivitas_gerbang_kendaraans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.aktivitas_gerbang_kendaraans_id_seq OWNER TO postgres;

--
-- Name: aktivitas_gerbang_kendaraans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aktivitas_gerbang_kendaraans_id_seq OWNED BY public.aktivitas_gerbang_kendaraans.id;


--
-- Name: data_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_members (
    id integer NOT NULL,
    nama character varying(255),
    no_hp character varying(255),
    perusahaan_id integer,
    akses_tiket boolean,
    akses_kartu boolean,
    no_kartu character varying(255),
    tgl_input timestamp with time zone,
    produk_id integer,
    tarif integer NOT NULL,
    biaya_member integer NOT NULL,
    biaya_kartu integer NOT NULL,
    periode daterange,
    user_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.data_members OWNER TO postgres;

--
-- Name: data_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.data_members_id_seq OWNER TO postgres;

--
-- Name: data_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_members_id_seq OWNED BY public.data_members.id;


--
-- Name: data_nomor_polisis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_nomor_polisis (
    id integer NOT NULL,
    data_member_id integer,
    kendaraan_id integer,
    nomor_polisi character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.data_nomor_polisis OWNER TO postgres;

--
-- Name: data_nomor_polisis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_nomor_polisis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.data_nomor_polisis_id_seq OWNER TO postgres;

--
-- Name: data_nomor_polisis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_nomor_polisis_id_seq OWNED BY public.data_nomor_polisis.id;


--
-- Name: data_vouchers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_vouchers (
    id integer NOT NULL,
    produk_voucher_id integer,
    periode daterange,
    diskon integer NOT NULL,
    model_bayar public.enum_data_vouchers_model_bayar,
    verifikasi public.enum_data_vouchers_verifikasi,
    no_tiket character varying(255),
    nomor_polisi character varying(255),
    kendaraan_id integer,
    keterangan character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.data_vouchers OWNER TO postgres;

--
-- Name: data_vouchers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.data_vouchers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.data_vouchers_id_seq OWNER TO postgres;

--
-- Name: data_vouchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_vouchers_id_seq OWNED BY public.data_vouchers.id;


--
-- Name: global_settings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.global_settings (
    id integer NOT NULL,
    nama_operator character varying(255),
    email_operator character varying(255),
    no_telp_operator character varying(255),
    no_fax_operator character varying(255),
    alamat_operator character varying(255),
    nama_lokasi character varying(255),
    email_lokasi character varying(255),
    no_telp_lokasi character varying(255),
    no_fax_lokasi character varying(255),
    alamat_lokasi character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.global_settings OWNER TO postgres;

--
-- Name: global_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.global_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.global_settings_id_seq OWNER TO postgres;

--
-- Name: global_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.global_settings_id_seq OWNED BY public.global_settings.id;


--
-- Name: kendaraans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kendaraans (
    id integer NOT NULL,
    nama_kendaraan character varying(255),
    tipe_kendaraan_id integer,
    status boolean,
    user_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.kendaraans OWNER TO postgres;

--
-- Name: kendaraans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kendaraans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.kendaraans_id_seq OWNER TO postgres;

--
-- Name: kendaraans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kendaraans_id_seq OWNED BY public.kendaraans.id;


--
-- Name: laporan_riwayat_transaksi_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.laporan_riwayat_transaksi_members (
    id integer NOT NULL,
    no integer,
    nomor_tiket character varying(255),
    waktu_masuk timestamp with time zone,
    gerbang_masuk_id integer,
    jenis_kendaraan_id integer,
    nomor_polisi character varying(255),
    waktu_keluar character varying(255),
    pintu_keluar_id integer,
    durasi_parkir character varying(255),
    denda character varying(255),
    total_pembayaran character varying(255),
    jenis_transaksi character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.laporan_riwayat_transaksi_members OWNER TO postgres;

--
-- Name: laporan_riwayat_transaksi_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.laporan_riwayat_transaksi_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.laporan_riwayat_transaksi_members_id_seq OWNER TO postgres;

--
-- Name: laporan_riwayat_transaksi_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.laporan_riwayat_transaksi_members_id_seq OWNED BY public.laporan_riwayat_transaksi_members.id;


--
-- Name: laporan_transaksi_batals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.laporan_transaksi_batals (
    id integer NOT NULL,
    no_tiket character varying(255),
    tanggal_masuk timestamp with time zone,
    pintu_masuk_id integer,
    tanggal_pembatalan timestamp with time zone,
    alasan_pembatalan character varying(255),
    penjelasan_pembatalan character varying(255),
    user_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.laporan_transaksi_batals OWNER TO postgres;

--
-- Name: laporan_transaksi_batals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.laporan_transaksi_batals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.laporan_transaksi_batals_id_seq OWNER TO postgres;

--
-- Name: laporan_transaksi_batals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.laporan_transaksi_batals_id_seq OWNED BY public.laporan_transaksi_batals.id;


--
-- Name: level_penggunas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.level_penggunas (
    id integer NOT NULL,
    nama character varying(255),
    hak_akses jsonb,
    perusahaan_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.level_penggunas OWNER TO postgres;

--
-- Name: level_penggunas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.level_penggunas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.level_penggunas_id_seq OWNER TO postgres;

--
-- Name: level_penggunas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.level_penggunas_id_seq OWNED BY public.level_penggunas.id;


--
-- Name: nama_interfaces; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nama_interfaces (
    id integer NOT NULL,
    nama_interface character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.nama_interfaces OWNER TO postgres;

--
-- Name: nama_interfaces_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nama_interfaces_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nama_interfaces_id_seq OWNER TO postgres;

--
-- Name: nama_interfaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nama_interfaces_id_seq OWNED BY public.nama_interfaces.id;


--
-- Name: nama_printers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nama_printers (
    id integer NOT NULL,
    nama_printer character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.nama_printers OWNER TO postgres;

--
-- Name: nama_printers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nama_printers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nama_printers_id_seq OWNER TO postgres;

--
-- Name: nama_printers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nama_printers_id_seq OWNED BY public.nama_printers.id;


--
-- Name: parameters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parameters (
    id integer NOT NULL,
    nama character varying(255),
    nilai character varying(255),
    keterangan character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.parameters OWNER TO postgres;

--
-- Name: parameters_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.parameters_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.parameters_id_seq OWNER TO postgres;

--
-- Name: parameters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parameters_id_seq OWNED BY public.parameters.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    jenis_payment character varying(255),
    status boolean,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO postgres;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: permasalahan_atau_perbaikans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.permasalahan_atau_perbaikans (
    id integer NOT NULL,
    judul_permasalahan character varying(255),
    tanggal_permasalahan character varying(255),
    kategori_permasalahan public.enum_permasalahan_atau_perbaikans_kategori_permasalahan,
    pos_id integer,
    hardware_atau_alat character varying(255),
    penyebab_permasalahan text,
    keterangan_permasalahan text,
    nama_pelapor character varying(255),
    status_permasalahan public.enum_permasalahan_atau_perbaikans_status_permasalahan,
    tanggal_perbaikan character varying(255),
    jenis_perbaikan character varying(255),
    status_perbaikan public.enum_permasalahan_atau_perbaikans_status_perbaikan,
    penanganan text,
    keterangan_penanganan text,
    nama_yang_menangani character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.permasalahan_atau_perbaikans OWNER TO postgres;

--
-- Name: permasalahan_atau_perbaikans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.permasalahan_atau_perbaikans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.permasalahan_atau_perbaikans_id_seq OWNER TO postgres;

--
-- Name: permasalahan_atau_perbaikans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permasalahan_atau_perbaikans_id_seq OWNED BY public.permasalahan_atau_perbaikans.id;


--
-- Name: perusahaans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perusahaans (
    id integer NOT NULL,
    nama character varying(255),
    jenis_perusahaan public.enum_perusahaans_jenis_perusahaan,
    kontak character varying(255),
    status boolean,
    user_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.perusahaans OWNER TO postgres;

--
-- Name: perusahaans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.perusahaans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.perusahaans_id_seq OWNER TO postgres;

--
-- Name: perusahaans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perusahaans_id_seq OWNED BY public.perusahaans.id;


--
-- Name: pos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pos (
    id integer NOT NULL,
    kode character varying(255),
    keterangan character varying(255),
    tipe_pos public.enum_pos_tipe_pos,
    tipe_manless_id integer,
    tipe_kendaraan public.enum_pos_tipe_kendaraan,
    kamera_1 boolean,
    kamera_2 boolean,
    nama_printer_id integer,
    nama_interface_id integer,
    com_port character varying(255),
    otorisasi boolean,
    synchronize character varying(255),
    user_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.pos OWNER TO postgres;

--
-- Name: pos_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pos_id_seq OWNER TO postgres;

--
-- Name: pos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pos_id_seq OWNED BY public.pos.id;


--
-- Name: produk_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produk_members (
    id integer NOT NULL,
    nama character varying(255),
    periode daterange,
    list_id_kendaraan character varying(255)[],
    max_kendaraan integer,
    tarif integer NOT NULL,
    biaya_kartu integer NOT NULL,
    biaya_ganti_nopol integer NOT NULL,
    status boolean,
    user_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.produk_members OWNER TO postgres;

--
-- Name: produk_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produk_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produk_members_id_seq OWNER TO postgres;

--
-- Name: produk_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produk_members_id_seq OWNED BY public.produk_members.id;


--
-- Name: produk_vouchers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produk_vouchers (
    id integer NOT NULL,
    nama character varying(255),
    periode daterange,
    list_id_kendaraan character varying(255)[],
    diskon integer NOT NULL,
    model_pembayaran public.enum_produk_vouchers_model_pembayaran,
    metode_verifikasi public.enum_produk_vouchers_metode_verifikasi,
    status boolean,
    user_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.produk_vouchers OWNER TO postgres;

--
-- Name: produk_vouchers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.produk_vouchers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.produk_vouchers_id_seq OWNER TO postgres;

--
-- Name: produk_vouchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produk_vouchers_id_seq OWNED BY public.produk_vouchers.id;


--
-- Name: riwayat_ganti_nomor_polisi_v2; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.riwayat_ganti_nomor_polisi_v2 (
    id integer NOT NULL,
    data_member_id integer NOT NULL,
    nomor_polisi_lama character varying(255) NOT NULL,
    nomor_polisi_baru character varying(255) NOT NULL,
    kendaraan_lama_id integer,
    kendaraan_baru_id integer,
    keterangan character varying(255),
    tgl_ganti timestamp with time zone NOT NULL,
    user_id integer NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    produk_id integer
);


ALTER TABLE public.riwayat_ganti_nomor_polisi_v2 OWNER TO postgres;

--
-- Name: riwayat_ganti_nomor_polisi_v2_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.riwayat_ganti_nomor_polisi_v2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.riwayat_ganti_nomor_polisi_v2_id_seq OWNER TO postgres;

--
-- Name: riwayat_ganti_nomor_polisi_v2_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.riwayat_ganti_nomor_polisi_v2_id_seq OWNED BY public.riwayat_ganti_nomor_polisi_v2.id;


--
-- Name: riwayat_transaksi_ganti_nopols; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.riwayat_transaksi_ganti_nopols (
    id integer NOT NULL,
    tgl_transaksi timestamp with time zone,
    nomor_polisi_lama character varying(255),
    nomor_polisi_baru character varying(255),
    tarif integer NOT NULL,
    keterangan character varying(255),
    user_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.riwayat_transaksi_ganti_nopols OWNER TO postgres;

--
-- Name: riwayat_transaksi_ganti_nopols_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.riwayat_transaksi_ganti_nopols_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.riwayat_transaksi_ganti_nopols_id_seq OWNER TO postgres;

--
-- Name: riwayat_transaksi_ganti_nopols_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.riwayat_transaksi_ganti_nopols_id_seq OWNED BY public.riwayat_transaksi_ganti_nopols.id;


--
-- Name: riwayat_transaksi_kartu_members; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.riwayat_transaksi_kartu_members (
    id integer NOT NULL,
    tgl_transaksi timestamp with time zone,
    no_kartu character varying(255),
    tarif integer NOT NULL,
    keterangan character varying(255),
    user_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.riwayat_transaksi_kartu_members OWNER TO postgres;

--
-- Name: riwayat_transaksi_kartu_members_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.riwayat_transaksi_kartu_members_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.riwayat_transaksi_kartu_members_id_seq OWNER TO postgres;

--
-- Name: riwayat_transaksi_kartu_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.riwayat_transaksi_kartu_members_id_seq OWNED BY public.riwayat_transaksi_kartu_members.id;


--
-- Name: riwayat_transaksi_member; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.riwayat_transaksi_member (
    id integer NOT NULL,
    tgl_transaksi timestamp with time zone NOT NULL,
    produk_id integer NOT NULL,
    tarif integer NOT NULL,
    masa_aktif character varying(255)[] NOT NULL,
    user_id integer NOT NULL,
    data_member_id integer NOT NULL
);


ALTER TABLE public.riwayat_transaksi_member OWNER TO postgres;

--
-- Name: riwayat_transaksi_member_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.riwayat_transaksi_member_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.riwayat_transaksi_member_id_seq OWNER TO postgres;

--
-- Name: riwayat_transaksi_member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.riwayat_transaksi_member_id_seq OWNED BY public.riwayat_transaksi_member.id;


--
-- Name: shifts; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.shifts (
    id integer NOT NULL,
    nama_shift character varying(255),
    awal_shift time without time zone,
    akhir_shift time without time zone,
    status boolean,
    user_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.shifts OWNER TO postgres;

--
-- Name: shifts_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.shifts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.shifts_id_seq OWNER TO postgres;

--
-- Name: shifts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shifts_id_seq OWNED BY public.shifts.id;


--
-- Name: tarif_dendas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tarif_dendas (
    id integer NOT NULL,
    kendaraan_id integer NOT NULL,
    denda_tiket integer NOT NULL,
    denda_stnk integer NOT NULL,
    denda_member boolean,
    status boolean,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.tarif_dendas OWNER TO postgres;

--
-- Name: tarif_dendas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tarif_dendas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tarif_dendas_id_seq OWNER TO postgres;

--
-- Name: tarif_dendas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tarif_dendas_id_seq OWNED BY public.tarif_dendas.id;


--
-- Name: tarif_parkirs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tarif_parkirs (
    id integer NOT NULL,
    kendaraan_id integer,
    grace_period integer,
    tarif_grace_period integer,
    rotasi_pertama integer,
    tarif_rotasi_pertama integer,
    rotasi_kedua integer,
    tarif_rotasi_kedua integer,
    rotasi_ketiga integer,
    tarif_rotasi_ketiga integer,
    tarif_maksimal integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.tarif_parkirs OWNER TO postgres;

--
-- Name: tarif_parkirs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tarif_parkirs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tarif_parkirs_id_seq OWNER TO postgres;

--
-- Name: tarif_parkirs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tarif_parkirs_id_seq OWNED BY public.tarif_parkirs.id;


--
-- Name: tenants; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tenants (
    id integer NOT NULL,
    nama_tenant character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.tenants OWNER TO postgres;

--
-- Name: tenants_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tenants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tenants_id_seq OWNER TO postgres;

--
-- Name: tenants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tenants_id_seq OWNED BY public.tenants.id;


--
-- Name: tipe_dendas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipe_dendas (
    id integer NOT NULL,
    tipe_denda character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.tipe_dendas OWNER TO postgres;

--
-- Name: tipe_dendas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipe_dendas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipe_dendas_id_seq OWNER TO postgres;

--
-- Name: tipe_dendas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipe_dendas_id_seq OWNED BY public.tipe_dendas.id;


--
-- Name: tipe_kendaraans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipe_kendaraans (
    id integer NOT NULL,
    tipe_kendaraan character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.tipe_kendaraans OWNER TO postgres;

--
-- Name: tipe_kendaraans_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipe_kendaraans_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipe_kendaraans_id_seq OWNER TO postgres;

--
-- Name: tipe_kendaraans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipe_kendaraans_id_seq OWNED BY public.tipe_kendaraans.id;


--
-- Name: tipe_manlesses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipe_manlesses (
    id integer NOT NULL,
    tipe_manless character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.tipe_manlesses OWNER TO postgres;

--
-- Name: tipe_manlesses_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipe_manlesses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipe_manlesses_id_seq OWNER TO postgres;

--
-- Name: tipe_manlesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipe_manlesses_id_seq OWNED BY public.tipe_manlesses.id;


--
-- Name: transaksis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transaksis (
    id integer NOT NULL,
    tanggal_masuk timestamp with time zone,
    pintu_masuk_id integer,
    no_tiket character varying(255),
    is_manual boolean,
    kendaraan_id integer,
    nomor_polisi character varying(255),
    pintu_keluar_id integer,
    tanggal_keluar timestamp with time zone,
    petugas_id integer,
    shift_id integer,
    denda boolean,
    tipe_denda_id integer,
    is_active boolean,
    jenis_pembayaran_id integer,
    biaya_parkir character varying(255),
    id_data_voucher integer,
    jumlah_denda_stnk integer NOT NULL,
    jumlah_denda_tiket integer NOT NULL,
    "interval" character varying(255),
    keterangan_atau_penjelasan character varying(255),
    id_data_member integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.transaksis OWNER TO postgres;

--
-- Name: transaksis_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transaksis_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaksis_id_seq OWNER TO postgres;

--
-- Name: transaksis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaksis_id_seq OWNED BY public.transaksis.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    nama character varying(255),
    jenis_kelamin public.enum_users_jenis_kelamin,
    no_hp character varying(255),
    alamat_lengkap character varying(255),
    username character varying(255),
    password character varying(255),
    perusahaan_id integer,
    level_pengguna_id integer,
    status boolean,
    added_by integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    tenant_id integer
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: aktivitas_gerbang_kendaraans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aktivitas_gerbang_kendaraans ALTER COLUMN id SET DEFAULT nextval('public.aktivitas_gerbang_kendaraans_id_seq'::regclass);


--
-- Name: data_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_members ALTER COLUMN id SET DEFAULT nextval('public.data_members_id_seq'::regclass);


--
-- Name: data_nomor_polisis id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis ALTER COLUMN id SET DEFAULT nextval('public.data_nomor_polisis_id_seq'::regclass);


--
-- Name: data_vouchers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_vouchers ALTER COLUMN id SET DEFAULT nextval('public.data_vouchers_id_seq'::regclass);


--
-- Name: global_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_settings ALTER COLUMN id SET DEFAULT nextval('public.global_settings_id_seq'::regclass);


--
-- Name: kendaraans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kendaraans ALTER COLUMN id SET DEFAULT nextval('public.kendaraans_id_seq'::regclass);


--
-- Name: laporan_riwayat_transaksi_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_riwayat_transaksi_members ALTER COLUMN id SET DEFAULT nextval('public.laporan_riwayat_transaksi_members_id_seq'::regclass);


--
-- Name: laporan_transaksi_batals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_transaksi_batals ALTER COLUMN id SET DEFAULT nextval('public.laporan_transaksi_batals_id_seq'::regclass);


--
-- Name: level_penggunas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas ALTER COLUMN id SET DEFAULT nextval('public.level_penggunas_id_seq'::regclass);


--
-- Name: nama_interfaces id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nama_interfaces ALTER COLUMN id SET DEFAULT nextval('public.nama_interfaces_id_seq'::regclass);


--
-- Name: nama_printers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nama_printers ALTER COLUMN id SET DEFAULT nextval('public.nama_printers_id_seq'::regclass);


--
-- Name: parameters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parameters ALTER COLUMN id SET DEFAULT nextval('public.parameters_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: permasalahan_atau_perbaikans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permasalahan_atau_perbaikans ALTER COLUMN id SET DEFAULT nextval('public.permasalahan_atau_perbaikans_id_seq'::regclass);


--
-- Name: perusahaans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perusahaans ALTER COLUMN id SET DEFAULT nextval('public.perusahaans_id_seq'::regclass);


--
-- Name: pos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos ALTER COLUMN id SET DEFAULT nextval('public.pos_id_seq'::regclass);


--
-- Name: produk_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_members ALTER COLUMN id SET DEFAULT nextval('public.produk_members_id_seq'::regclass);


--
-- Name: produk_vouchers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_vouchers ALTER COLUMN id SET DEFAULT nextval('public.produk_vouchers_id_seq'::regclass);


--
-- Name: riwayat_ganti_nomor_polisi_v2 id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_ganti_nomor_polisi_v2 ALTER COLUMN id SET DEFAULT nextval('public.riwayat_ganti_nomor_polisi_v2_id_seq'::regclass);


--
-- Name: riwayat_transaksi_ganti_nopols id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_ganti_nopols ALTER COLUMN id SET DEFAULT nextval('public.riwayat_transaksi_ganti_nopols_id_seq'::regclass);


--
-- Name: riwayat_transaksi_kartu_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_kartu_members ALTER COLUMN id SET DEFAULT nextval('public.riwayat_transaksi_kartu_members_id_seq'::regclass);


--
-- Name: riwayat_transaksi_member id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_member ALTER COLUMN id SET DEFAULT nextval('public.riwayat_transaksi_member_id_seq'::regclass);


--
-- Name: shifts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shifts ALTER COLUMN id SET DEFAULT nextval('public.shifts_id_seq'::regclass);


--
-- Name: tarif_dendas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_dendas ALTER COLUMN id SET DEFAULT nextval('public.tarif_dendas_id_seq'::regclass);


--
-- Name: tarif_parkirs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_parkirs ALTER COLUMN id SET DEFAULT nextval('public.tarif_parkirs_id_seq'::regclass);


--
-- Name: tenants id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenants ALTER COLUMN id SET DEFAULT nextval('public.tenants_id_seq'::regclass);


--
-- Name: tipe_dendas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_dendas ALTER COLUMN id SET DEFAULT nextval('public.tipe_dendas_id_seq'::regclass);


--
-- Name: tipe_kendaraans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_kendaraans ALTER COLUMN id SET DEFAULT nextval('public.tipe_kendaraans_id_seq'::regclass);


--
-- Name: tipe_manlesses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_manlesses ALTER COLUMN id SET DEFAULT nextval('public.tipe_manlesses_id_seq'::regclass);


--
-- Name: transaksis id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis ALTER COLUMN id SET DEFAULT nextval('public.transaksis_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: aktivitas_gerbang_kendaraans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aktivitas_gerbang_kendaraans (id, tiket, plat_nomor, kendaraan_id, waktu, lokasi_gerbang, buka_atau_tutup, petugas_id, status_palang, tipe_gerbang, data_member_id, "createdAt", "updatedAt", tenant_id) FROM stdin;
101	TIK099_04	B4044DD	4	20:40:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 17:26:33.24+07	2025-07-31 17:26:33.24+07	1
105	TIK099_05	B5055EE	5	20:45:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 17:27:03.406+07	2025-07-31 17:27:03.406+07	1
107	TIK099_06	B6066FF	1	20:50:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 17:27:19.51+07	2025-07-31 17:27:19.51+07	1
115	TIK099_07	B7077GG	3	20:55:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 17:27:58.466+07	2025-07-31 17:27:58.466+07	1
118	TIK099_08	B8088HH	3	21:00:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 17:28:15.335+07	2025-07-31 17:28:15.335+07	1
121	TIK099_09	B9099II	4	21:05:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 17:28:32.191+07	2025-07-31 17:28:32.191+07	1
123	TIK099_10	B0000JJ	5	21:10:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 17:28:43.322+07	2025-07-31 17:28:43.322+07	1
125	TIK099_11	B1111KK	1	21:15:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 17:28:56.026+07	2025-07-31 17:28:56.026+07	1
130	TIK099_12	B2222LL	3	21:20:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 17:29:15.821+07	2025-07-31 17:29:15.821+07	1
131	TIK099_13	B3333MM	3	21:25:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 17:29:27.139+07	2025-07-31 17:29:27.139+07	1
132	TIK099_14	B4444NN	4	21:30:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 17:29:37.62+07	2025-07-31 17:29:37.62+07	1
135	TIK099_15	B5555OO	5	21:35:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 17:30:05.317+07	2025-07-31 17:30:05.317+07	1
136	TIK099_16	B6161AA	1	21:40:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:18:01.619+07	2025-07-31 18:18:01.619+07	1
141	TIK099_17	B7171BB	1	21:45:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:18:34.778+07	2025-07-31 18:18:34.778+07	1
142	TIK099_17	B7171BB	1	21:45:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:19:05.123+07	2025-07-31 18:19:05.123+07	1
143	TIK099_18	B8181CC	1	21:50:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:19:25.522+07	2025-07-31 18:19:25.522+07	1
145	TIK099_19	B9191DD	4	21:55:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:19:40.301+07	2025-07-31 18:19:40.301+07	1
147	TIK099_20	B0202EE	5	22:00:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:19:57.791+07	2025-07-31 18:19:57.791+07	1
148	TIK099_21	B1212FF	1	22:05:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:20:11.622+07	2025-07-31 18:20:11.622+07	1
149	TIK099_22	B2222GG	1	22:10:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:20:45.363+07	2025-07-31 18:20:45.363+07	1
150	TIK099_23	B3232HH	1	22:15:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:21:05.511+07	2025-07-31 18:21:05.511+07	1
151	TIK099_24	B4242II	4	22:20:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:21:22.136+07	2025-07-31 18:21:22.136+07	1
90	TIK099_03	B3033CC	3	20:35:00	Masuk	Terbuka	7	Sukses	In	1	2025-07-28 17:23:51.757+07	2025-07-31 17:23:51.757+07	1
94	TIK099_02	B2022BB	1	20:30:00	Masuk	Terbuka	7	Sukses	In	1	2025-07-28 17:24:21.71+07	2025-07-31 17:24:21.71+07	1
95	TIK099_02	B2022BB	3	20:30:00	Masuk	Terbuka	7	Sukses	In	1	2025-07-29 17:25:24.627+07	2025-07-31 17:25:24.627+07	1
96	TIK099_02	B2022BB	5	20:30:00	Masuk	Terbuka	7	Sukses	In	1	2025-07-30 17:25:33.3+07	2025-07-31 17:25:33.3+07	1
99	TIK099_02	B2022BB	11	20:30:00	Masuk	Terbuka	7	Sukses	In	1	2025-07-30 17:25:47.768+07	2025-07-31 17:25:47.768+07	1
78	TIK500	R1020A	1	05:30:00	Masuk	Tertutup	1	Sukses	Out	1	2025-07-29 13:12:49.981+07	2025-07-29 13:12:49.981+07	1
79	TIK500	R1020A	1	05:30:00	Masuk	Tertutup	1	Sukses	Out	1	2025-07-29 13:12:49.981+07	2025-07-29 13:12:49.981+07	1
80	TIK099	M1011LL	1	20:25:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-29 16:55:43.003+07	2025-07-29 16:55:43.003+07	1
153	TIK099_25	B5252JJ	5	22:25:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:21:36.202+07	2025-07-31 18:21:36.202+07	1
154	TIK099_26	B6262KK	1	22:30:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:21:46.035+07	2025-07-31 18:21:46.035+07	1
155	TIK099_27	B7272LL	1	22:35:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:22:07.795+07	2025-07-31 18:22:07.795+07	1
156	TIK099_28	B8282MM	1	22:40:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:22:26.557+07	2025-07-31 18:22:26.557+07	1
157	TIK099_29	B9292NN	4	22:45:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:22:39.071+07	2025-07-31 18:22:39.071+07	1
81	TIK099_01	B1011AA	1	20:25:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-28 17:22:26.972+07	2025-07-31 17:22:26.972+07	1
161	TIK099_31	B0304OO	5	20:15:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:38:04.781+07	2025-07-31 18:38:04.781+07	1
162	TIK099_31	B0304OO	5	21:05:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:38:16.48+07	2025-07-31 18:38:16.48+07	1
163	TIK099_32	B0305OO	5	18:00:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:38:26.079+07	2025-07-31 18:38:26.079+07	1
164	TIK099_32	B0305OO	5	19:10:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:38:38.091+07	2025-07-31 18:38:38.091+07	1
165	TIK099_33	B0306OO	5	15:20:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:38:50.523+07	2025-07-31 18:38:50.523+07	1
166	TIK099_33	B0306OO	5	16:00:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:38:54.908+07	2025-07-31 18:38:54.908+07	1
167	TIK099_34	B0307OO	5	14:10:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:39:03.875+07	2025-07-31 18:39:03.875+07	1
168	TIK099_34	B0307OO	5	15:30:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:39:21.66+07	2025-07-31 18:39:21.66+07	1
169	TIK099_31	B0304OO	5	20:15:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:40:44.326+07	2025-07-31 18:40:44.326+07	1
170	TIK099_31	B0304OO	5	21:05:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:40:53.754+07	2025-07-31 18:40:53.754+07	1
171	TIK099_35	B0308OO	5	11:00:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:41:13.754+07	2025-07-31 18:41:13.754+07	1
172	TIK099_35	B0308OO	5	11:45:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:41:25.204+07	2025-07-31 18:41:25.204+07	1
173	TIK099_36	B0309OO	5	10:30:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:41:35.054+07	2025-07-31 18:41:35.054+07	1
174	TIK099_36	B0309OO	5	11:20:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:41:40.638+07	2025-07-31 18:41:40.638+07	1
175	TIK099_37	B0310OO	5	09:15:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:41:48.413+07	2025-07-31 18:41:48.413+07	1
176	TIK099_37	B0310OO	5	10:00:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:41:54.331+07	2025-07-31 18:41:54.331+07	1
177	TIK099_38	B0311OO	5	08:00:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:42:03.291+07	2025-07-31 18:42:03.291+07	1
178	TIK099_38	B0311OO	5	09:10:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:42:10.339+07	2025-07-31 18:42:10.339+07	1
179	TIK099_39	B0312OO	5	07:20:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:42:19.337+07	2025-07-31 18:42:19.337+07	1
180	TIK099_39	B0312OO	5	08:30:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:42:27.05+07	2025-07-31 18:42:27.05+07	1
181	TIK099_40	B0313OO	5	13:10:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:42:34.545+07	2025-07-31 18:42:34.545+07	1
182	TIK099_40	B0313OO	5	14:00:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:42:42.41+07	2025-07-31 18:42:42.41+07	1
183	TIK099_41	B0314OO	5	17:45:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:42:47.502+07	2025-07-31 18:42:47.502+07	1
184	TIK099_41	B0314OO	5	18:30:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:42:53.118+07	2025-07-31 18:42:53.118+07	1
185	TIK099_42	B0315OO	5	12:20:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:43:02.528+07	2025-07-31 18:43:02.528+07	1
186	TIK099_42	B0315OO	5	13:00:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:43:08.314+07	2025-07-31 18:43:08.314+07	1
187	TIK099_43	B0316OO	5	16:40:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:43:14.667+07	2025-07-31 18:43:14.667+07	1
188	TIK099_43	B0316OO	5	17:25:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:43:22.465+07	2025-07-31 18:43:22.465+07	1
189	TIK099_44	B0317OO	5	19:30:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:43:30.74+07	2025-07-31 18:43:30.74+07	1
190	TIK099_44	B0317OO	5	20:15:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:43:37.124+07	2025-07-31 18:43:37.124+07	1
191	TIK100	M1011LL	1	20:25:00	Masuk	Terbuka	1	Sukses	In	1	2025-08-01 07:29:29.096+07	2025-08-01 07:29:29.096+07	1
158	TIK099_30	B0303OO	5	22:50:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-31 18:22:58.297+07	2025-07-31 18:22:58.297+07	1
160	TIK099_30	B0303OO	5	23:30:00	Keluar	Terbuka	1	Sukses	Out	1	2025-07-31 18:36:55.786+07	2025-07-31 18:36:55.786+07	1
193	TIK101	M1011LL	5	21:10:00	Keluar	Terbuka	7	Sukses	Out	1	2025-07-29 07:47:33+07	2025-07-29 07:47:33+07	1
192	TIK101	M1011LL	5	20:25:00	Masuk	Terbuka	1	Sukses	In	1	2025-07-29 07:40:33.214+07	2025-07-29 07:40:33.214+07	1
\.


--
-- Data for Name: data_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_members (id, nama, no_hp, perusahaan_id, akses_tiket, akses_kartu, no_kartu, tgl_input, produk_id, tarif, biaya_member, biaya_kartu, periode, user_id, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Itmamul Fahmi	082102342343	1	t	t	4435345345345	2000-05-31 07:00:00+07	1	50000	50000	50000	[2025-06-01,2025-06-03)	1	2025-07-27 15:22:20.417+07	2025-07-27 15:22:20.417+07	1
3	Andri	1901901	18	t	t	19189891	2025-08-02 00:00:00+07	23	510000	510000	25000	[2025-08-13,2025-08-26)	1	2025-08-02 16:35:22.766+07	2025-08-02 16:35:22.766+07	1
4	Andri	1901901	18	t	t	19189891	2025-08-02 00:00:00+07	23	510000	510000	25000	[2025-08-13,2025-08-26)	1	2025-08-02 16:38:34.98+07	2025-08-02 16:38:34.98+07	1
5	Andri	1901901	18	t	t	19189891	2025-08-02 00:00:00+07	23	510000	510000	25000	[2025-08-13,2025-08-26)	1	2025-08-02 16:38:56.039+07	2025-08-02 16:38:56.039+07	1
6	Andri	1901901	18	t	t	19189891	2025-08-02 00:00:00+07	23	510000	510000	25000	[2025-08-13,2025-08-26)	1	2025-08-02 16:39:10.502+07	2025-08-02 16:39:10.502+07	1
7	Andri	1901901	18	t	t	19189891	2025-08-02 00:00:00+07	23	510000	510000	25000	[2025-08-13,2025-08-26)	1	2025-08-02 16:39:16.337+07	2025-08-02 16:39:16.337+07	1
10	Budi	0811223344	18	t	t	22334455	2025-08-02 00:00:00+07	24	515000	515000	25000	[2025-08-14,2025-08-27)	1	2025-08-02 16:51:52.124+07	2025-08-02 16:51:52.124+07	1
11	Budi	0811223344	18	t	t	22334455	2025-08-02 00:00:00+07	24	515000	515000	25000	[2025-08-14,2025-08-27)	1	2025-08-02 16:52:17.567+07	2025-08-02 16:52:17.567+07	1
12	Citra	0822334455	18	t	t	99887766	2025-08-02 00:00:00+07	25	500000	500000	25000	[2025-08-15,2025-08-28)	7	2025-08-02 16:52:32.097+07	2025-08-02 16:52:32.097+07	1
13	Dedi	0833445566	18	t	t	11223344	2025-08-02 00:00:00+07	26	520000	520000	25000	[2025-08-16,2025-08-29)	1	2025-08-02 16:52:44.572+07	2025-08-02 16:52:44.572+07	1
14	Dedi	0833445566	18	t	t	11223344	2025-08-02 00:00:00+07	26	520000	520000	25000	[2025-08-16,2025-08-29)	1	2025-08-02 16:52:51.511+07	2025-08-02 16:52:51.511+07	1
15	Dedi	0833445566	18	t	t	11223344	2025-08-02 00:00:00+07	26	520000	520000	25000	[2025-08-16,2025-08-29)	1	2025-08-02 16:52:54.068+07	2025-08-02 16:52:54.068+07	1
19	Eka	0844556677	18	t	t	33445566	2025-08-02 00:00:00+07	15	495000	495000	25000	[2025-08-17,2025-08-30)	1	2025-08-02 16:53:22.93+07	2025-08-02 16:53:22.93+07	1
22	Farah	0855667788	18	t	t	66778899	2025-08-02 00:00:00+07	17	510000	510000	25000	[2025-08-18,2025-08-31)	1	2025-08-02 16:53:51.995+07	2025-08-02 16:53:51.995+07	1
23	Gilang	0866778899	18	t	t	44556677	2025-08-02 00:00:00+07	15	505000	505000	25000	[2025-08-19,2025-09-01)	7	2025-08-02 16:54:10.468+07	2025-08-02 16:54:10.468+07	1
24	Gilang	0866778899	18	t	t	44556677	2025-08-02 00:00:00+07	15	505000	505000	25000	[2025-08-19,2025-09-01)	7	2025-08-02 16:54:18.952+07	2025-08-02 16:54:18.952+07	1
26	Hana	0877889900	18	t	t	77889900	2025-08-02 00:00:00+07	15	515000	515000	25000	[2025-08-20,2025-09-02)	8	2025-08-02 16:54:48.758+07	2025-08-02 16:54:48.758+07	1
27	Hana	0877889900	18	t	t	77889900	2025-08-02 00:00:00+07	15	515000	515000	25000	[2025-08-20,2025-09-02)	8	2025-08-02 16:54:55.927+07	2025-08-02 16:54:55.927+07	1
32	Indra	0888990011	18	t	t	99001122	2025-08-02 00:00:00+07	1	500000	500000	25000	[2025-08-21,2025-09-03)	7	2025-08-02 16:55:35.199+07	2025-08-02 16:55:35.199+07	1
33	Joko	0899001122	18	t	t	22110099	2025-08-02 00:00:00+07	1	520000	520000	25000	[2025-08-22,2025-09-04)	1	2025-08-02 16:56:06.714+07	2025-08-02 16:56:06.714+07	1
34	Joko	0899001122	18	t	t	22110099	2025-08-02 00:00:00+07	1	520000	520000	25000	[2025-08-22,2025-09-04)	1	2025-08-02 16:56:09.956+07	2025-08-02 16:56:09.956+07	1
35	Kirana	0811221133	18	t	t	11332244	2025-08-02 00:00:00+07	1	500000	500000	25000	[2025-08-23,2025-09-05)	7	2025-08-02 16:56:29.777+07	2025-08-02 16:56:29.777+07	1
36	Kirana	0811221133	18	t	t	11332244	2025-08-02 00:00:00+07	1	500000	500000	25000	[2025-08-23,2025-09-05)	7	2025-08-02 16:56:33.72+07	2025-08-02 16:56:33.72+07	1
37	Lukman	0822332244	18	t	t	99889988	2025-08-02 00:00:00+07	3	515000	515000	25000	[2025-08-24,2025-09-06)	1	2025-08-02 16:56:54.097+07	2025-08-02 16:56:54.097+07	1
38	Lukman	0822332244	18	t	t	99889988	2025-08-02 00:00:00+07	3	515000	515000	25000	[2025-08-24,2025-09-06)	1	2025-08-02 16:56:59.114+07	2025-08-02 16:56:59.114+07	1
39	Maya	0833443355	18	t	t	55443322	2025-08-02 00:00:00+07	1	505000	505000	25000	[2025-08-25,2025-09-07)	1	2025-08-02 16:57:19.363+07	2025-08-02 16:57:19.363+07	1
40	Nanda	0844554466	18	t	t	77665544	2025-08-02 00:00:00+07	1	510000	510000	25000	[2025-08-26,2025-09-08)	1	2025-08-02 16:57:37.426+07	2025-08-02 16:57:37.426+07	1
41	Nanda	0844554466	18	t	t	77665544	2025-08-02 00:00:00+07	1	510000	510000	25000	[2025-08-26,2025-09-08)	1	2025-08-02 16:57:43.692+07	2025-08-02 16:57:43.692+07	1
\.


--
-- Data for Name: data_nomor_polisis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_nomor_polisis (id, data_member_id, kendaraan_id, nomor_polisi, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	1	1	AB1234AC	2025-07-27 15:22:20.946+07	2025-07-27 15:22:20.946+07	1
2	1	1	AB1235AC	2025-07-27 15:22:20.946+07	2025-07-27 15:22:20.946+07	1
3	1	1	AB1236AC	2025-07-27 15:22:20.946+07	2025-07-27 15:22:20.946+07	1
4	3	23	9898989a9009	2025-08-02 16:35:22.797+07	2025-08-02 16:35:22.797+07	1
5	3	24	09190109	2025-08-02 16:35:22.797+07	2025-08-02 16:35:22.797+07	1
11	7	23	00a09a898989a9009	2025-08-02 16:39:16.346+07	2025-08-02 16:39:16.346+07	1
12	7	24	09kakk190109	2025-08-02 16:39:16.346+07	2025-08-02 16:39:16.346+07	1
15	11	1	B1234XYZ	2025-08-02 16:52:18.18+07	2025-08-02 16:52:18.18+07	1
16	11	1	B5678ABC	2025-08-02 16:52:18.18+07	2025-08-02 16:52:18.18+07	1
17	12	27	D8899EE	2025-08-02 16:52:33.071+07	2025-08-02 16:52:33.071+07	1
18	12	28	F1122GG	2025-08-02 16:52:33.071+07	2025-08-02 16:52:33.071+07	1
23	15	1	AB1234CD	2025-08-02 16:52:54.077+07	2025-08-02 16:52:54.077+07	1
24	15	1	EF5678GH	2025-08-02 16:52:54.077+07	2025-08-02 16:52:54.077+07	1
25	19	1	BG1111ZZ	2025-08-02 16:53:23.686+07	2025-08-02 16:53:23.686+07	1
26	19	1	BG2222YY	2025-08-02 16:53:23.686+07	2025-08-02 16:53:23.686+07	1
27	22	1	DK9090KL	2025-08-02 16:53:52.005+07	2025-08-02 16:53:52.005+07	1
28	22	1	DK8080LM	2025-08-02 16:53:52.005+07	2025-08-02 16:53:52.005+07	1
31	24	23	AG123ABC	2025-08-02 16:54:18.961+07	2025-08-02 16:54:18.961+07	1
32	24	13	AG456DEF	2025-08-02 16:54:18.961+07	2025-08-02 16:54:18.961+07	1
35	27	11	F001AA	2025-08-02 16:54:55.935+07	2025-08-02 16:54:55.935+07	1
36	27	13	F002BB	2025-08-02 16:54:55.935+07	2025-08-02 16:54:55.935+07	1
37	32	11	AA1234ZZ	2025-08-02 16:55:35.214+07	2025-08-02 16:55:35.214+07	1
38	32	1	BB5678YY	2025-08-02 16:55:35.214+07	2025-08-02 16:55:35.214+07	1
41	34	1	Z0098GH	2025-08-02 16:56:09.966+07	2025-08-02 16:56:09.966+07	1
42	34	1	Z0077GH	2025-08-02 16:56:09.966+07	2025-08-02 16:56:09.966+07	1
45	36	13	L123ABC	2025-08-02 16:56:33.729+07	2025-08-02 16:56:33.729+07	1
46	36	1	L456DEF	2025-08-02 16:56:33.729+07	2025-08-02 16:56:33.729+07	1
49	38	15	AE12345	2025-08-02 16:56:59.125+07	2025-08-02 16:56:59.125+07	1
50	38	11	AE54321	2025-08-02 16:56:59.125+07	2025-08-02 16:56:59.125+07	1
51	39	11	BM1111CD	2025-08-02 16:57:19.372+07	2025-08-02 16:57:19.372+07	1
52	39	11	BM2222EF	2025-08-02 16:57:19.372+07	2025-08-02 16:57:19.372+07	1
55	41	1	AB1001XY	2025-08-02 16:57:43.711+07	2025-08-02 16:57:43.711+07	1
56	41	1	AB1002YZ	2025-08-02 16:57:43.711+07	2025-08-02 16:57:43.711+07	1
\.


--
-- Data for Name: data_vouchers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_vouchers (id, produk_voucher_id, periode, diskon, model_bayar, verifikasi, no_tiket, nomor_polisi, kendaraan_id, keterangan, "createdAt", "updatedAt", tenant_id) FROM stdin;
2	1	[2025-07-01,2025-07-07)	10000	Check Out	Tiket	TIK001	B1234XYZ	1	Diskon promosi pintu barat	2025-07-30 18:17:29.067+07	2025-07-30 18:17:29.067+07	1
5	1	[2025-07-10,2025-07-20)	15000	Check In	Nopol	ioaioaoi	D5678ABC	3	Voucher member bulanan	2025-07-30 18:19:22.217+07	2025-07-30 18:19:22.217+07	1
6	3	[2025-07-25,2025-07-30)	8000	Check Out	Tiket	TIK002	F1212ZZ	3	Promo akhir bulan	2025-07-30 18:19:55.156+07	2025-07-30 18:19:55.156+07	1
\.


--
-- Data for Name: global_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.global_settings (id, nama_operator, email_operator, no_telp_operator, no_fax_operator, alamat_operator, nama_lokasi, email_lokasi, no_telp_lokasi, no_fax_lokasi, alamat_lokasi, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Evosist Parking	cs@evosist.com 	085817028312	085817028312	Jl. Alamanda No.227A Cilangkap Cipayung Jakarta Timur 	Pasar Megah Jaya	pasarmegahjaya@gmail.com	098768900232	08754345678	Pekuncen, Banyumas	2025-07-25 12:43:22.524+07	2025-07-27 16:51:57.865+07	1
\.


--
-- Data for Name: kendaraans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kendaraans (id, nama_kendaraan, tipe_kendaraan_id, status, user_id, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Xenia	1	t	1	2025-07-27 14:29:25.466+07	2025-07-27 14:29:25.466+07	1
3	Sedan	\N	t	1	2025-07-30 17:24:26.762+07	2025-07-30 17:24:26.762+07	1
4	\N	\N	\N	\N	2025-07-30 17:24:54.238+07	2025-07-30 17:24:54.238+07	1
6	\N	\N	\N	\N	2025-07-30 17:25:25.163+07	2025-07-30 17:25:25.163+07	1
10	Sedan	\N	t	7	2025-07-31 16:56:55.041+07	2025-07-31 16:56:55.041+07	1
11	Avanza	1	t	7	2025-07-31 17:01:28.269+07	2025-07-31 17:01:28.269+07	1
12	Xenia	1	t	7	2025-07-31 17:01:37.154+07	2025-07-31 17:01:37.154+07	1
13	Jazz	1	t	7	2025-07-31 17:01:43.632+07	2025-07-31 17:01:43.632+07	1
15	Innova	1	t	7	2025-07-31 17:02:08.596+07	2025-07-31 17:02:08.596+07	1
16	Brio	1	t	7	2025-07-31 17:02:14.331+07	2025-07-31 17:02:14.331+07	1
18	CRV	1	t	7	2025-07-31 17:02:32.87+07	2025-07-31 17:02:32.87+07	1
20	Fortuner	1	t	7	2025-07-31 17:02:50.253+07	2025-07-31 17:02:50.253+07	1
21	Veloz	1	t	7	2025-07-31 17:08:45.409+07	2025-07-31 17:08:45.409+07	1
22	Civic	1	t	7	2025-07-31 17:08:57.275+07	2025-07-31 17:08:57.275+07	1
23	Yaris	1	t	7	2025-07-31 17:09:04.041+07	2025-07-31 17:09:04.041+07	1
24	Ertiga	1	t	7	2025-07-31 17:09:09.438+07	2025-07-31 17:09:09.438+07	1
26	Pajero	1	t	7	2025-07-31 17:09:25.165+07	2025-07-31 17:09:25.165+07	1
27	Rush	1	t	7	2025-07-31 17:09:31.442+07	2025-07-31 17:09:31.442+07	1
28	Wuling	1	t	7	2025-07-31 17:09:39.773+07	2025-07-31 17:09:39.773+07	1
30	Almaz	1	t	7	2025-07-31 17:09:53.447+07	2025-07-31 17:09:53.447+07	1
32	Minibus A	2	t	1	2025-07-31 17:17:48.216+07	2025-07-31 17:17:48.216+07	1
33	Motor B	3	t	1	2025-07-31 17:17:56.352+07	2025-07-31 17:17:56.352+07	1
34	Bus C	4	t	1	2025-07-31 17:18:28.746+07	2025-07-31 17:18:28.746+07	1
35	Truk D	5	t	1	2025-07-31 17:18:44.062+07	2025-07-31 17:18:44.062+07	1
36	Pickup E	6	t	1	2025-07-31 17:18:49.968+07	2025-07-31 17:18:49.968+07	1
5	Kendaraan Keluarga	5	\N	\N	2025-07-30 17:25:15.29+07	2025-07-30 17:25:15.29+07	1
\.


--
-- Data for Name: laporan_riwayat_transaksi_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.laporan_riwayat_transaksi_members (id, no, nomor_tiket, waktu_masuk, gerbang_masuk_id, jenis_kendaraan_id, nomor_polisi, waktu_keluar, pintu_keluar_id, durasi_parkir, denda, total_pembayaran, jenis_transaksi, "createdAt", "updatedAt", tenant_id) FROM stdin;
\.


--
-- Data for Name: laporan_transaksi_batals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.laporan_transaksi_batals (id, no_tiket, tanggal_masuk, pintu_masuk_id, tanggal_pembatalan, alasan_pembatalan, penjelasan_pembatalan, user_id, "createdAt", "updatedAt", tenant_id) FROM stdin;
\.


--
-- Data for Name: level_penggunas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.level_penggunas (id, nama, hak_akses, perusahaan_id, "createdAt", "updatedAt", tenant_id) FROM stdin;
5	Admin2	[{"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "User"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "konfigurasi_menu": true}, "nama": "Level Akses"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Produk Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Produk Voucher"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "perpanjang": true, "ganti_kartu": true, "ganti_nopol": true}, "nama": "Data Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Data Voucher"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "POS"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Kendaraan"}, {"aksi": {"create": true, "delete": true, "update": true}, "nama": "Shift"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Tarif Parkir"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Tarif Denda"}, {"aksi": {"read": true, "update": true}, "nama": "Parameter"}, {"aksi": {"read": true, "update": true}, "nama": "Global"}, {"aksi": {"read": true, "update": true}, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": null, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": {"read": true, "delete": true, "update": true, "create_perbaikan": true, "create_permasalahan": true}, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Overnight"}, {"aksi": null, "nama": "Pendapatan Parkir"}, {"aksi": null, "nama": "Pendapatan Gabungan"}, {"aksi": null, "nama": "Pendapatan Member"}, {"aksi": null, "nama": "Pendapatan Voucher"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Audit Transaksi"}, {"aksi": null, "nama": "Settlement Cashless"}]}]	\N	2025-08-02 13:07:17.556+07	2025-08-02 13:07:17.556+07	1
6	A	[{"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master Data", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Perusahaan"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "pengaturan": true}, "nama": "Level Pengguna"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Data Pengguna"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Pos (In/Out)"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Data Kendaraan"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Produk Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "perpanjang": true, "ganti_kartu": true, "riwayat_transaksi": true, "ganti_nomor_polisi": true}, "nama": "Data Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Produk Voucher"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Data Voucher"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Shift"}]}, {"nama_menu": "Laporan Data", "nama_sub_menu": [{"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Kendaraan"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Pendapatan Parkir"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null, "batalkan_transaksi": true}, "nama": "Transaksi Batal"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Audit Transaksi"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null, "unggah_file": true}, "nama": "Settlement Cashless"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": {"read": null, "create": true, "delete": null, "update": null}, "nama": "Tambah Transaksi"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Riwayat Transaksi"}]}, {"nama_menu": "Pengaturan", "nama_sub_menu": [{"aksi": {"read": true, "create": null, "delete": null, "update": true}, "nama": "Tarif Parkir"}, {"aksi": {"read": true, "create": null, "delete": null, "update": true, "aktif_nonaktif": true}, "nama": "Tarif Denda"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null, "aktif_nonaktif": true}, "nama": "Pembayaran"}, {"aksi": {"read": true, "create": null, "delete": null, "update": true}, "nama": "Parameter"}, {"aksi": {"read": true, "create": null, "delete": null, "update": true}, "nama": "Global"}]}, {"nama_menu": "Bantuan", "nama_sub_menu": [{"aksi": {"read": false, "create": false, "delete": false, "update": true, "proses_data_perbaikan": true}, "nama": "Tiket"}]}]	19	2025-08-02 13:07:32.545+07	2025-08-02 13:07:32.545+07	1
1	Super Admin	[{"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master Data", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Perusahaan"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "pengaturan": true}, "nama": "Level Pengguna"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Data Pengguna"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Pos (In/Out)"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Data Kendaraan"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Produk Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "perpanjang": true, "ganti_kartu": true, "riwayat_transaksi": true, "ganti_nomor_polisi": true}, "nama": "Data Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Produk Voucher"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Data Voucher"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Shift"}]}, {"nama_menu": "Laporan Data", "nama_sub_menu": [{"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Kendaraan"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Pendapatan Parkir"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null, "batalkan_transaksi": true}, "nama": "Transaksi Batal"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Audit Transaksi"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null, "unggah_file": true}, "nama": "Settlement Cashless"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": {"read": null, "create": true, "delete": null, "update": null}, "nama": "Tambah Transaksi"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Riwayat Transaksi"}]}, {"nama_menu": "Pengaturan", "nama_sub_menu": [{"aksi": {"read": true, "create": null, "delete": null, "update": true}, "nama": "Tarif Parkir"}, {"aksi": {"read": true, "create": null, "delete": null, "update": true, "aktif_nonaktif": true}, "nama": "Tarif Denda"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null, "aktif_nonaktif": true}, "nama": "Pembayaran"}, {"aksi": {"read": true, "create": null, "delete": null, "update": true}, "nama": "Parameter"}, {"aksi": {"read": true, "create": null, "delete": null, "update": true}, "nama": "Global"}]}, {"nama_menu": "Bantuan", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": true, "update": true, "proses_data_perbaikan": true}, "nama": "Tiket"}]}]	1	2025-07-24 12:10:55.045+07	2025-07-24 12:10:55.045+07	1
4	Andi	[{"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master Data", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Perusahaan"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "pengaturan": true}, "nama": "Level Pengguna"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Data Pengguna"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Pos (In/Out)"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Data Kendaraan"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Produk Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "perpanjang": true, "ganti_kartu": true, "riwayat_transaksi": true, "ganti_nomor_polisi": true}, "nama": "Data Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Produk Voucher"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Data Voucher"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Shift"}]}, {"nama_menu": "Laporan Data", "nama_sub_menu": [{"aksi": {"read": false, "create": null, "delete": null, "update": null}, "nama": "Kendaraan"}, {"aksi": {"read": false, "create": null, "delete": null, "update": null}, "nama": "Pendapatan Parkir"}, {"aksi": {"read": false, "create": null, "delete": null, "update": null, "batalkan_transaksi": true}, "nama": "Transaksi Batal"}, {"aksi": {"read": false, "create": null, "delete": null, "update": null}, "nama": "Audit Transaksi"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null, "unggah_file": false}, "nama": "Settlement Cashless"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": {"read": null, "create": false, "delete": null, "update": null}, "nama": "Tambah Transaksi"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Riwayat Transaksi"}]}, {"nama_menu": "Pengaturan", "nama_sub_menu": [{"aksi": {"read": true, "create": null, "delete": null, "update": true}, "nama": "Tarif Parkir"}, {"aksi": {"read": true, "create": null, "delete": null, "update": true, "aktif_nonaktif": true}, "nama": "Tarif Denda"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null, "aktif_nonaktif": true}, "nama": "Pembayaran"}, {"aksi": {"read": false, "create": null, "delete": null, "update": true}, "nama": "Parameter"}, {"aksi": {"read": true, "create": null, "delete": null, "update": true}, "nama": "Global"}]}, {"nama_menu": "Bantuan", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": false, "update": true, "proses_data_perbaikan": true}, "nama": "Tiket"}]}]	20	2025-08-02 13:02:50.316+07	2025-08-02 13:02:50.316+07	1
7	Admin Operasional	[{"aksi": {"read": true}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": {"read": true}, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": {"read": true, "update": true}, "nama": "Produk Member"}, {"aksi": {"read": true}, "nama": "Produk Voucher"}, {"aksi": {"read": true, "update": true, "perpanjang": true}, "nama": "Data Member"}, {"aksi": {"read": true}, "nama": "Data Voucher"}, {"aksi": {"read": true}, "nama": "POS"}, {"aksi": {"read": true, "update": true}, "nama": "Kendaraan"}, {"aksi": {"read": true, "update": true}, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": {"read": true}, "nama": "Tarif Parkir"}, {"aksi": null, "nama": "Tarif Denda"}, {"aksi": {"read": true}, "nama": "Parameter"}, {"aksi": {"read": true}, "nama": "Global"}, {"aksi": {"read": true}, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": null, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": {"read": true, "create_permasalahan": true}, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": {"read": true}, "nama": "Kendaraan"}, {"aksi": null, "nama": "Overnight"}, {"aksi": {"read": true}, "nama": "Pendapatan Parkir"}, {"aksi": null, "nama": "Pendapatan Gabungan"}, {"aksi": null, "nama": "Pendapatan Member"}, {"aksi": null, "nama": "Pendapatan Voucher"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Audit Transaksi"}, {"aksi": null, "nama": "Settlement Cashless"}]}]	\N	2025-08-02 13:32:59.976+07	2025-08-02 13:32:59.976+07	1
8	Admin Keuangan	[{"aksi": {"read": true}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": null, "nama": "Produk Member"}, {"aksi": null, "nama": "Produk Voucher"}, {"aksi": {"read": true}, "nama": "Data Member"}, {"aksi": {"read": true}, "nama": "Data Voucher"}, {"aksi": null, "nama": "POS"}, {"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Shift"}, {"aksi": {"read": true}, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": {"read": true}, "nama": "Tarif Parkir"}, {"aksi": {"read": true}, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": {"read": true}, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": null, "nama": "Manual mix"}, {"aksi": {"read": true}, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Overnight"}, {"aksi": {"read": true}, "nama": "Pendapatan Parkir"}, {"aksi": {"read": true}, "nama": "Pendapatan Gabungan"}, {"aksi": {"read": true}, "nama": "Pendapatan Member"}, {"aksi": {"read": true}, "nama": "Pendapatan Voucher"}, {"aksi": {"read": true}, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Audit Transaksi"}, {"aksi": {"read": true}, "nama": "Settlement Cashless"}]}]	2	2025-08-02 13:36:16.038+07	2025-08-02 13:36:16.038+07	1
9	Supervisor Shift	[{"aksi": {"read": true}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": null, "nama": "Produk Member"}, {"aksi": null, "nama": "Produk Voucher"}, {"aksi": {"read": true}, "nama": "Data Member"}, {"aksi": null, "nama": "Data Voucher"}, {"aksi": {"read": true}, "nama": "POS"}, {"aksi": {"read": true}, "nama": "Kendaraan"}, {"aksi": {"create": true, "delete": true, "update": true}, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": null, "nama": "Tarif Parkir"}, {"aksi": null, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": null, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": {"read": true}, "nama": "Manual mix"}, {"aksi": {"read": true}, "nama": "Pembatalan Transaksi"}, {"aksi": {"read": true, "update": true}, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Overnight"}, {"aksi": null, "nama": "Pendapatan Parkir"}, {"aksi": null, "nama": "Pendapatan Gabungan"}, {"aksi": null, "nama": "Pendapatan Member"}, {"aksi": null, "nama": "Pendapatan Voucher"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Audit Transaksi"}, {"aksi": null, "nama": "Settlement Cashless"}]}]	3	2025-08-02 13:37:12.523+07	2025-08-02 13:37:12.523+07	1
10	Petugas Gerbang Masuk	[{"aksi": null, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": null, "nama": "Produk Member"}, {"aksi": null, "nama": "Produk Voucher"}, {"aksi": {"read": true}, "nama": "Data Member"}, {"aksi": null, "nama": "Data Voucher"}, {"aksi": null, "nama": "POS"}, {"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": null, "nama": "Tarif Parkir"}, {"aksi": null, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": null, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": null, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": {"create_permasalahan": true}, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Overnight"}, {"aksi": null, "nama": "Pendapatan Parkir"}, {"aksi": null, "nama": "Pendapatan Gabungan"}, {"aksi": null, "nama": "Pendapatan Member"}, {"aksi": null, "nama": "Pendapatan Voucher"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Audit Transaksi"}, {"aksi": null, "nama": "Settlement Cashless"}]}]	3	2025-08-02 13:37:50.586+07	2025-08-02 13:37:50.586+07	1
11	Petugas Gerbang Keluar	[{"aksi": null, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": null, "nama": "Produk Member"}, {"aksi": null, "nama": "Produk Voucher"}, {"aksi": {"read": true}, "nama": "Data Member"}, {"aksi": null, "nama": "Data Voucher"}, {"aksi": null, "nama": "POS"}, {"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": null, "nama": "Tarif Parkir"}, {"aksi": null, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": null, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": null, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": {"create_perbaikan": true}, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Overnight"}, {"aksi": null, "nama": "Pendapatan Parkir"}, {"aksi": null, "nama": "Pendapatan Gabungan"}, {"aksi": null, "nama": "Pendapatan Member"}, {"aksi": null, "nama": "Pendapatan Voucher"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Audit Transaksi"}, {"aksi": null, "nama": "Settlement Cashless"}]}]	3	2025-08-02 13:38:17.61+07	2025-08-02 13:38:17.61+07	1
12	Petugas Customer Service	[{"aksi": {"read": true}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": null, "nama": "Produk Member"}, {"aksi": null, "nama": "Produk Voucher"}, {"aksi": {"read": true, "ganti_kartu": true, "ganti_nopol": true}, "nama": "Data Member"}, {"aksi": null, "nama": "Data Voucher"}, {"aksi": null, "nama": "POS"}, {"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": null, "nama": "Tarif Parkir"}, {"aksi": null, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": null, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": null, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Overnight"}, {"aksi": null, "nama": "Pendapatan Parkir"}, {"aksi": null, "nama": "Pendapatan Gabungan"}, {"aksi": null, "nama": "Pendapatan Member"}, {"aksi": null, "nama": "Pendapatan Voucher"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Audit Transaksi"}, {"aksi": null, "nama": "Settlement Cashless"}]}]	3	2025-08-02 13:38:54.396+07	2025-08-02 13:38:54.396+07	1
13	Petugas POS	[{"aksi": null, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": null, "nama": "Produk Member"}, {"aksi": null, "nama": "Produk Voucher"}, {"aksi": null, "nama": "Data Member"}, {"aksi": null, "nama": "Data Voucher"}, {"aksi": {"read": true, "update": true}, "nama": "POS"}, {"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": null, "nama": "Tarif Parkir"}, {"aksi": null, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": null, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": {"read": true}, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Overnight"}, {"aksi": null, "nama": "Pendapatan Parkir"}, {"aksi": null, "nama": "Pendapatan Gabungan"}, {"aksi": null, "nama": "Pendapatan Member"}, {"aksi": null, "nama": "Pendapatan Voucher"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Audit Transaksi"}, {"aksi": null, "nama": "Settlement Cashless"}]}]	4	2025-08-02 13:39:23.807+07	2025-08-02 13:39:23.807+07	1
14	Staff Keanggotaan	[{"aksi": {"read": true}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": {"read": true}, "nama": "Produk Member"}, {"aksi": null, "nama": "Produk Voucher"}, {"aksi": {"read": true, "create": true, "update": true, "perpanjang": true}, "nama": "Data Member"}, {"aksi": null, "nama": "Data Voucher"}, {"aksi": null, "nama": "POS"}, {"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": null, "nama": "Tarif Parkir"}, {"aksi": null, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": null, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": null, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Overnight"}, {"aksi": null, "nama": "Pendapatan Parkir"}, {"aksi": null, "nama": "Pendapatan Gabungan"}, {"aksi": null, "nama": "Pendapatan Member"}, {"aksi": null, "nama": "Pendapatan Voucher"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Audit Transaksi"}, {"aksi": null, "nama": "Settlement Cashless"}]}]	4	2025-08-02 13:39:49.065+07	2025-08-02 13:39:49.065+07	1
15	Admin Produk Voucher	[{"aksi": {"read": true}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": null, "nama": "Produk Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Produk Voucher"}, {"aksi": null, "nama": "Data Member"}, {"aksi": {"read": true, "update": true}, "nama": "Data Voucher"}, {"aksi": null, "nama": "POS"}, {"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": null, "nama": "Tarif Parkir"}, {"aksi": null, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": null, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": null, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Overnight"}, {"aksi": null, "nama": "Pendapatan Parkir"}, {"aksi": null, "nama": "Pendapatan Gabungan"}, {"aksi": null, "nama": "Pendapatan Member"}, {"aksi": {"read": true}, "nama": "Pendapatan Voucher"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Audit Transaksi"}, {"aksi": null, "nama": "Settlement Cashless"}]}]	4	2025-08-02 13:40:50.082+07	2025-08-02 13:40:50.082+07	1
16	Admin Tarif	[{"aksi": {"read": true}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": null, "nama": "Produk Member"}, {"aksi": null, "nama": "Produk Voucher"}, {"aksi": null, "nama": "Data Member"}, {"aksi": null, "nama": "Data Voucher"}, {"aksi": null, "nama": "POS"}, {"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "update": true}, "nama": "Tarif Parkir"}, {"aksi": {"read": true, "create": true, "update": true}, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": null, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": null, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Overnight"}, {"aksi": null, "nama": "Pendapatan Parkir"}, {"aksi": null, "nama": "Pendapatan Gabungan"}, {"aksi": null, "nama": "Pendapatan Member"}, {"aksi": null, "nama": "Pendapatan Voucher"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Audit Transaksi"}, {"aksi": null, "nama": "Settlement Cashless"}]}]	4	2025-08-02 13:41:23.502+07	2025-08-02 13:41:23.502+07	1
17	Manajer Laporan	[{"aksi": {"read": true}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": null, "nama": "Produk Member"}, {"aksi": null, "nama": "Produk Voucher"}, {"aksi": null, "nama": "Data Member"}, {"aksi": null, "nama": "Data Voucher"}, {"aksi": null, "nama": "POS"}, {"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": null, "nama": "Tarif Parkir"}, {"aksi": null, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": null, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": null, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": {"read": true}, "nama": "Kendaraan"}, {"aksi": {"read": true}, "nama": "Overnight"}, {"aksi": {"read": true}, "nama": "Pendapatan Parkir"}, {"aksi": {"read": true}, "nama": "Pendapatan Gabungan"}, {"aksi": {"read": true}, "nama": "Pendapatan Member"}, {"aksi": {"read": true}, "nama": "Pendapatan Voucher"}, {"aksi": {"read": true}, "nama": "Pembatalan Transaksi"}, {"aksi": {"read": true}, "nama": "Audit Transaksi"}, {"aksi": {"read": true}, "nama": "Settlement Cashless"}]}]	5	2025-08-02 13:41:57.102+07	2025-08-02 13:41:57.102+07	1
18	Supervisor Kendaraan	[{"aksi": {"read": true}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": null, "nama": "Produk Member"}, {"aksi": null, "nama": "Produk Voucher"}, {"aksi": null, "nama": "Data Member"}, {"aksi": null, "nama": "Data Voucher"}, {"aksi": null, "nama": "POS"}, {"aksi": {"read": true, "delete": true, "update": true}, "nama": "Kendaraan"}, {"aksi": null, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": null, "nama": "Tarif Parkir"}, {"aksi": null, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": null, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": null, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": {"read": true}, "nama": "Kendaraan"}, {"aksi": {"read": true}, "nama": "Audit Transaksi"}]}]	6	2025-08-02 13:42:48.063+07	2025-08-02 13:42:48.063+07	1
19	Admin Transaksi Manual	[{"aksi": null, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": null, "nama": "Produk Member"}, {"aksi": null, "nama": "Produk Voucher"}, {"aksi": null, "nama": "Data Member"}, {"aksi": null, "nama": "Data Voucher"}, {"aksi": null, "nama": "POS"}, {"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": null, "nama": "Tarif Parkir"}, {"aksi": null, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": null, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Audit Transaksi"}]}]	6	2025-08-02 13:43:17.257+07	2025-08-02 13:43:17.257+07	1
20	Admin Pembatalan Transaksi	[{"aksi": null, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": null, "nama": "User"}, {"aksi": null, "nama": "Level Akses"}, {"aksi": null, "nama": "Produk Member"}, {"aksi": null, "nama": "Produk Voucher"}, {"aksi": null, "nama": "Data Member"}, {"aksi": null, "nama": "Data Voucher"}, {"aksi": null, "nama": "POS"}, {"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Shift"}, {"aksi": null, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": null, "nama": "Tarif Parkir"}, {"aksi": null, "nama": "Tarif Denda"}, {"aksi": null, "nama": "Parameter"}, {"aksi": null, "nama": "Global"}, {"aksi": null, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Manual mix"}, {"aksi": null, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": {"read": true}, "nama": "Pembatalan Transaksi"}, {"aksi": {"read": true}, "nama": "Audit Transaksi"}]}]	7	2025-08-02 13:43:41.815+07	2025-08-02 13:43:41.815+07	1
\.


--
-- Data for Name: nama_interfaces; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nama_interfaces (id, nama_interface, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	BGI	2025-07-27 14:28:28.708+07	2025-07-27 14:28:28.708+07	1
\.


--
-- Data for Name: nama_printers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nama_printers (id, nama_printer, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	EPSON TM-T82 Receipt	2025-07-27 14:28:25.324+07	2025-07-27 14:28:25.324+07	1
\.


--
-- Data for Name: parameters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parameters (id, nama, nilai, keterangan, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Bayar Member Secara Berjenjang	false	Pembayaran member secara berjenjang ketika keluar	2025-07-27 14:28:11.612+07	2025-07-27 14:28:11.612+07	1
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, jenis_payment, status, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Prepaid Card	t	2025-07-27 14:27:49.716+07	2025-07-27 14:27:49.716+07	1
2	\N	\N	2025-07-30 17:26:43.904+07	2025-07-30 17:26:43.904+07	1
3	 QRIS	t	2025-07-30 17:27:31.671+07	2025-07-30 17:27:31.671+07	1
4	 E-Wallet	t	2025-07-30 17:28:17.64+07	2025-07-30 17:28:17.64+07	1
5	 Cash	t	2025-07-30 17:28:39.57+07	2025-07-30 17:28:39.57+07	1
6	Cash	t	2025-07-30 17:28:45.821+07	2025-07-30 17:28:45.821+07	1
\.


--
-- Data for Name: permasalahan_atau_perbaikans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permasalahan_atau_perbaikans (id, judul_permasalahan, tanggal_permasalahan, kategori_permasalahan, pos_id, hardware_atau_alat, penyebab_permasalahan, keterangan_permasalahan, nama_pelapor, status_permasalahan, tanggal_perbaikan, jenis_perbaikan, status_perbaikan, penanganan, keterangan_penanganan, nama_yang_menangani, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Error Barrier Gate	31-05-2021	Sistem	1	Hardware	Ada short dalam kelistrikan	Segera melakukan perbaikan	Fahmi	Pending	31-05-2004		Pending				2025-07-27 14:45:30.144+07	2025-07-27 14:45:30.144+07	1
\.


--
-- Data for Name: perusahaans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perusahaans (id, nama, jenis_perusahaan, kontak, status, user_id, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Evolusi Sistem Digital	Pemilik Gedung	08235345345	t	\N	2025-07-24 12:10:52.493+07	2025-07-24 12:10:52.493+07	1
2	PT ABC	Pemilik Gedung	081345234543	f	1	2025-07-24 16:49:39.564+07	2025-07-24 16:49:39.564+07	1
3	Pasr LEgi	Pemilik Gedung	9191919	f	1	2025-08-01 17:32:59.65+07	2025-08-01 17:32:59.65+07	1
4	Gedung Parkir Plaza Sudirman	Pemilik Gedung	021-555-1234	f	1	2025-08-01 21:46:13.654+07	2025-08-01 21:46:13.654+07	1
5	Gedung Parkir Thamrin Square	Pemilik Gedung	021-789-1122	f	1	2025-08-01 21:46:36.687+07	2025-08-01 21:46:36.687+07	1
6	Gedung Parkir Central Park	Tenant	021-2952-3344	f	1	2025-08-01 21:46:54.056+07	2025-08-01 21:46:54.056+07	1
7	Gedung Parkir Grand Cempaka Tower	Developer	021-421-8880	f	1	2025-08-01 21:47:30.506+07	2025-08-01 21:47:30.506+07	1
8	Gedung Parkir Senayan Trade Center	Tenant	021-572-9071	f	1	2025-08-01 21:47:46.246+07	2025-08-01 21:47:46.246+07	1
9	Gedung Parkir Mangga Dua Square	Developer	021-612-3456	f	1	2025-08-01 22:06:04.391+07	2025-08-01 22:06:04.391+07	1
10	Gedung Parkir Medan Merdeka	Pemilik Gedung	021-345-6677	f	1	2025-08-01 22:06:34.926+07	2025-08-01 22:06:34.926+07	1
11	Gedung Parkir Pacific Place	Pemilik Gedung	021-5140-5678	f	1	2025-08-01 22:07:03.544+07	2025-08-01 22:07:03.544+07	1
12	Gedung Parkir Kota Kasablanka	Pemilik Gedung	021-2946-7890	f	1	2025-08-01 22:07:21.166+07	2025-08-01 22:07:21.166+07	1
13	Parkiran Plaza Indonesia	Pemilik Gedung	021-3190-1234	f	1	2025-08-01 22:10:02.37+07	2025-08-01 22:10:02.37+07	1
14	Gedung Parkir FX Sudirman	Pemilik Gedung	021-2555-6789	f	1	2025-08-01 22:10:21.863+07	2025-08-01 22:10:21.863+07	1
15	Parkir Gedung Bursa Efek Jakarta	Pemilik Gedung	021-5151-4321	f	1	2025-08-01 22:10:41.644+07	2025-08-01 22:10:41.644+07	1
16	Gedung Wisma 46	Pemilik Gedung	021-5740-9876	f	1	2025-08-01 22:11:05.647+07	2025-08-01 22:11:05.647+07	1
17	The City Tower Jakarta	Pemilik Gedung	021-3901-2222	f	1	2025-08-01 22:12:11.519+07	2025-08-01 22:12:11.519+07	1
20	Gedung Graha Niaga Parkir	Pemilik Gedung	021-5202-3030	f	1	2025-08-01 22:13:15.386+07	2025-08-01 22:13:15.386+07	1
18	Parkiran Mall Taman Anggrek3	Pemilik Gedung	021-5639-77773	t	1	2025-08-01 22:12:39.07+07	2025-08-01 22:14:05.292+07	1
19	Menara Astra Parking	Pemilik Gedung	021-3001-1111	t	1	2025-08-01 22:12:56.932+07	2025-08-02 09:21:14.725+07	1
\.


--
-- Data for Name: pos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pos (id, kode, keterangan, tipe_pos, tipe_manless_id, tipe_kendaraan, kamera_1, kamera_2, nama_printer_id, nama_interface_id, com_port, otorisasi, synchronize, user_id, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	P1	Pos 1	In	1	All	t	t	1	1	1	t	1	1	2025-07-27 14:34:39.62+07	2025-07-27 14:34:39.62+07	1
2	POS123	Pos masuk utama	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-30 17:29:39.498+07	2025-07-30 17:29:39.498+07	1
3	keluar	Pos masuk utama	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-30 17:30:07.066+07	2025-07-30 17:30:07.066+07	1
4	tengah	Pos masuk utama	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-30 17:30:15.883+07	2025-07-30 17:30:15.883+07	1
5	POS001	Pos masuk 1	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:12:26.523+07	2025-07-31 16:12:26.523+07	1
6	POS002	Pos masuk 2	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:12:37.315+07	2025-07-31 16:12:37.315+07	1
7	POS003	Pos keluar 1	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:12:46.91+07	2025-07-31 16:12:46.91+07	1
8	POS004	Pos keluar 2	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:12:56.17+07	2025-07-31 16:12:56.17+07	1
9	POS005	Pos tengah	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:13:05.036+07	2025-07-31 16:13:05.036+07	1
10	POS006	Pos basement 1	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:13:15.035+07	2025-07-31 16:13:15.035+07	1
11	POS007	Pos basement 2	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:13:25.884+07	2025-07-31 16:13:25.884+07	1
12	POS008	Pos masuk motor	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:13:35.023+07	2025-07-31 16:13:35.023+07	1
13	POS009	Pos keluar motor	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:13:44.739+07	2025-07-31 16:13:44.739+07	1
14	POS010	Pos darurat 1	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:13:57.157+07	2025-07-31 16:13:57.157+07	1
15	POS011	Pos darurat 2	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:14:06.654+07	2025-07-31 16:14:06.654+07	1
16	POS013	Pos depan	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:14:28.177+07	2025-07-31 16:14:28.177+07	1
17	POS014	Pos loading	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:14:36.889+07	2025-07-31 16:14:36.889+07	1
18	POS015	Pos unloading	\N	\N	\N	\N	\N	\N	\N	\N	t	\N	\N	2025-07-31 16:14:44.6+07	2025-07-31 16:14:44.6+07	1
\.


--
-- Data for Name: produk_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produk_members (id, nama, periode, list_id_kendaraan, max_kendaraan, tarif, biaya_kartu, biaya_ganti_nopol, status, user_id, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Kartu Member 1	[2025-06-01,2025-06-10)	{1,1}	1	50000	50000	50000	f	1	2025-07-27 14:34:56.525+07	2025-08-02 14:36:05.217+07	1
2	Paket 1	[2025-08-29,2025-11-30)	{1,5,15}	19	2000	10000	11000	t	1	2025-08-02 14:35:51.606+07	2025-08-02 14:36:07.969+07	1
3	Paket AB	[2025-08-02,2025-12-31)	{12,11,20}	999	25000	50000	15000	f	1	2025-08-02 14:53:25.883+07	2025-08-02 14:53:25.883+07	1
4	Super	[2025-08-02,2025-08-15)	{15}	17000	950000	97500	20000	f	\N	2025-08-02 14:54:43.301+07	2025-08-02 14:54:43.301+07	1
5	Member Silver	\N	{1,2}	2	500000	25000	50000	t	1	2025-08-02 14:56:16.796+07	2025-08-02 14:56:16.796+07	1
6	Member Silver	[2025-08-02,2025-08-15)	{1,2}	2	500000	25000	50000	t	1	2025-08-02 14:57:48.391+07	2025-08-02 14:58:20.547+07	1
7	Silver Nova Pass	[2025-08-02,2025-08-15)	{1,2}	2	500000	25000	50000	t	1	2025-08-02 16:22:16.989+07	2025-08-02 16:22:16.989+07	1
12	Parkir Pro Max	[2025-08-04,2025-08-17)	{5,6}	2	510000	25000	50000	t	1	2025-08-02 16:23:03.467+07	2025-08-02 16:23:03.467+07	1
14	Sky Access Plus	[2025-08-05,2025-08-18)	{7,8}	2	505000	25000	50000	t	7	2025-08-02 16:23:17.615+07	2025-08-02 16:23:17.615+07	1
15	Midnight Rider Pass	[2025-08-06,2025-08-19)	{9,10}	2	500000	25000	50000	t	1	2025-08-02 16:23:28.118+07	2025-08-02 16:23:28.118+07	1
16	Midnight Rider Pass	[2025-08-06,2025-08-19)	{9,10}	2	500000	25000	50000	t	1	2025-08-02 16:23:45.216+07	2025-08-02 16:23:45.216+07	1
17	Velocity Member	[2025-08-07,2025-08-20)	{11,12}	2	495000	25000	50000	t	1	2025-08-02 16:23:55.224+07	2025-08-02 16:23:55.224+07	1
18	Silver Horizon	[2025-08-08,2025-08-21)	{13,14}	2	505000	25000	50000	t	1	2025-08-02 16:24:05.535+07	2025-08-02 16:24:05.535+07	1
19	MetroAccess Basic	[2025-08-09,2025-08-22)	{15,16}	2	500000	25000	50000	t	1	2025-08-02 16:24:14.182+07	2025-08-02 16:24:14.182+07	1
20	Access Flex 9	[2025-08-10,2025-08-23)	{17,18}	2	515000	25000	50000	t	1	2025-08-02 16:24:25.986+07	2025-08-02 16:24:25.986+07	1
21	Park Hero Silver	[2025-08-11,2025-08-24)	{19,20}	2	520000	25000	50000	t	1	2025-08-02 16:24:33.091+07	2025-08-02 16:24:33.091+07	1
22	Starlite Membership	[2025-08-12,2025-08-25)	{21,22}	2	500000	25000	50000	t	1	2025-08-02 16:24:41.308+07	2025-08-02 16:24:41.308+07	1
23	ParkWay Essential	[2025-08-13,2025-08-26)	{23,24}	2	510000	25000	50000	t	1	2025-08-02 16:24:51.359+07	2025-08-02 16:24:51.359+07	1
24	SilverJet Card	[2025-08-14,2025-08-27)	{25,26}	2	495000	25000	50000	t	1	2025-08-02 16:24:59.415+07	2025-08-02 16:24:59.415+07	1
25	Orbit Access Plan	[2025-08-15,2025-08-28)	{27,28}	2	500000	25000	50000	t	1	2025-08-02 16:25:07.142+07	2025-08-02 16:25:07.142+07	1
26	Aero Silver Entry	[2025-08-16,2025-08-29)	{29,30}	2	520000	25000	50000	t	1	2025-08-02 16:25:17.825+07	2025-08-02 16:25:17.825+07	1
\.


--
-- Data for Name: produk_vouchers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produk_vouchers (id, nama, periode, list_id_kendaraan, diskon, model_pembayaran, metode_verifikasi, status, user_id, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Tamu	[2025-05-31,2025-06-01)	{1,1}	2000	Check In	Tiket	t	1	2025-07-27 14:34:50.499+07	2025-07-27 14:34:50.499+07	1
3	Voucher Langganan	\N	{B1234XYZ,D5678ABC}	0	Check Out	Tiket	t	1	2025-07-30 17:31:29.328+07	2025-07-30 17:31:29.328+07	1
4	Promo Mingguan	\N	{F9012DEF,M1011LL}	5000	Check Out	Nopol	t	1	2025-07-30 17:33:27.087+07	2025-07-30 17:33:27.087+07	1
5	Voucher Event	\N	{B2222AA,D3333BB}	10190	Check Out	Tiket	f	1	2025-07-30 17:34:00.594+07	2025-07-30 17:34:00.594+07	1
\.


--
-- Data for Name: riwayat_ganti_nomor_polisi_v2; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.riwayat_ganti_nomor_polisi_v2 (id, data_member_id, nomor_polisi_lama, nomor_polisi_baru, kendaraan_lama_id, kendaraan_baru_id, keterangan, tgl_ganti, user_id, "createdAt", "updatedAt", produk_id) FROM stdin;
\.


--
-- Data for Name: riwayat_transaksi_ganti_nopols; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.riwayat_transaksi_ganti_nopols (id, tgl_transaksi, nomor_polisi_lama, nomor_polisi_baru, tarif, keterangan, user_id, "createdAt", "updatedAt", tenant_id) FROM stdin;
\.


--
-- Data for Name: riwayat_transaksi_kartu_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.riwayat_transaksi_kartu_members (id, tgl_transaksi, no_kartu, tarif, keterangan, user_id, "createdAt", "updatedAt", tenant_id) FROM stdin;
\.


--
-- Data for Name: riwayat_transaksi_member; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.riwayat_transaksi_member (id, tgl_transaksi, produk_id, tarif, masa_aktif, user_id, data_member_id) FROM stdin;
\.


--
-- Data for Name: shifts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shifts (id, nama_shift, awal_shift, akhir_shift, status, user_id, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Shift 1	08:00:00	16:00:00	f	1	2025-07-27 14:35:08.916+07	2025-08-01 06:32:56.12+07	1
\.


--
-- Data for Name: tarif_dendas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tarif_dendas (id, kendaraan_id, denda_tiket, denda_stnk, denda_member, status, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	1	7000	7000	t	t	2025-07-27 14:29:29.608+07	2025-07-27 14:29:29.608+07	1
3	1	50000	95000	f	f	2025-08-01 08:38:52.052+07	2025-08-01 08:38:52.052+07	1
\.


--
-- Data for Name: tarif_parkirs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tarif_parkirs (id, kendaraan_id, grace_period, tarif_grace_period, rotasi_pertama, tarif_rotasi_pertama, rotasi_kedua, tarif_rotasi_kedua, rotasi_ketiga, tarif_rotasi_ketiga, tarif_maksimal, "createdAt", "updatedAt", tenant_id) FROM stdin;
3	1	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-27 14:29:26.01+07	2025-07-27 14:29:26.01+07	1
4	3	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-30 17:24:26.914+07	2025-07-30 17:24:26.914+07	1
5	4	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-30 17:24:54.303+07	2025-07-30 17:24:54.303+07	1
6	5	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-30 17:25:15.356+07	2025-07-30 17:25:15.356+07	1
7	6	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-30 17:25:25.166+07	2025-07-30 17:25:25.166+07	1
8	10	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 16:56:55.049+07	2025-07-31 16:56:55.049+07	1
9	11	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:01:28.544+07	2025-07-31 17:01:28.544+07	1
10	12	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:01:37.158+07	2025-07-31 17:01:37.158+07	1
11	13	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:01:43.639+07	2025-07-31 17:01:43.639+07	1
12	15	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:02:08.768+07	2025-07-31 17:02:08.768+07	1
13	16	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:02:14.335+07	2025-07-31 17:02:14.335+07	1
14	18	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:02:32.991+07	2025-07-31 17:02:32.991+07	1
15	20	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:02:50.257+07	2025-07-31 17:02:50.257+07	1
16	21	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:08:45.588+07	2025-07-31 17:08:45.588+07	1
17	22	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:08:57.531+07	2025-07-31 17:08:57.531+07	1
18	23	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:09:04.044+07	2025-07-31 17:09:04.044+07	1
19	24	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:09:09.444+07	2025-07-31 17:09:09.444+07	1
20	26	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:09:25.17+07	2025-07-31 17:09:25.17+07	1
21	27	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:09:31.446+07	2025-07-31 17:09:31.446+07	1
22	28	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:09:39.776+07	2025-07-31 17:09:39.776+07	1
23	30	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:09:53.449+07	2025-07-31 17:09:53.449+07	1
24	32	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:17:48.377+07	2025-07-31 17:17:48.377+07	1
25	33	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:17:56.355+07	2025-07-31 17:17:56.355+07	1
26	34	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:18:29+07	2025-07-31 17:18:29+07	1
27	35	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:18:44.235+07	2025-07-31 17:18:44.235+07	1
28	36	\N	\N	\N	\N	\N	\N	\N	\N	\N	2025-07-31 17:18:49.971+07	2025-07-31 17:18:49.971+07	1
29	1	10	0	60	3000	120	5000	180	7000	25000	2025-08-01 08:38:31.74+07	2025-08-01 08:38:31.74+07	1
\.


--
-- Data for Name: tenants; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tenants (id, nama_tenant, "createdAt", "updatedAt") FROM stdin;
1	Evosist	2025-08-13 14:23:49.033+07	2025-08-13 14:23:49.033+07
\.


--
-- Data for Name: tipe_dendas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipe_dendas (id, tipe_denda, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Tidak Dapat Menunjukkan STNK	2025-07-27 14:28:16.823+07	2025-07-27 14:28:16.823+07	1
\.


--
-- Data for Name: tipe_kendaraans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipe_kendaraans (id, tipe_kendaraan, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Mobil	2025-07-27 14:28:07.031+07	2025-07-27 14:28:07.031+07	1
2	Minibus	2025-07-31 17:11:56.055+07	2025-07-31 17:11:56.055+07	1
3	Motor	2025-07-31 17:12:43.475+07	2025-07-31 17:12:43.475+07	1
4	Bus	2025-07-31 17:12:50.083+07	2025-07-31 17:12:50.083+07	1
5	Truk	2025-07-31 17:12:56.087+07	2025-07-31 17:12:56.087+07	1
6	Pickup	2025-07-31 17:13:02.279+07	2025-07-31 17:13:02.279+07	1
7	Minibus	2025-07-31 17:13:11.395+07	2025-07-31 17:13:11.395+07	1
8	SUV	2025-07-31 17:13:18.459+07	2025-07-31 17:13:18.459+07	1
9	Sedan	2025-07-31 17:13:24.387+07	2025-07-31 17:13:24.387+07	1
10	Hatchback	2025-07-31 17:13:30.949+07	2025-07-31 17:13:30.949+07	1
11	Box	2025-07-31 17:13:36.58+07	2025-07-31 17:13:36.58+07	1
12	Tronton	2025-07-31 17:13:42.126+07	2025-07-31 17:13:42.126+07	1
13	Trailer	2025-07-31 17:13:48.768+07	2025-07-31 17:13:48.768+07	1
14	City Car	2025-07-31 17:13:56.619+07	2025-07-31 17:13:56.619+07	1
15	MPV	2025-07-31 17:14:02.526+07	2025-07-31 17:14:02.526+07	1
16	Coupe	2025-07-31 17:14:08.745+07	2025-07-31 17:14:08.745+07	1
\.


--
-- Data for Name: tipe_manlesses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipe_manlesses (id, tipe_manless, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Loop 1 with Button and Feedback	2025-07-27 14:28:21.125+07	2025-07-27 14:28:21.125+07	1
\.


--
-- Data for Name: transaksis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaksis (id, tanggal_masuk, pintu_masuk_id, no_tiket, is_manual, kendaraan_id, nomor_polisi, pintu_keluar_id, tanggal_keluar, petugas_id, shift_id, denda, tipe_denda_id, is_active, jenis_pembayaran_id, biaya_parkir, id_data_voucher, jumlah_denda_stnk, jumlah_denda_tiket, "interval", keterangan_atau_penjelasan, id_data_member, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	2025-05-04 14:00:00+07	1	AABBCC	f	1	R2020AJ	1	2025-05-05 00:00:00+07	1	1	f	1	t	1	0	\N	0	0	10	keterangan	\N	2025-07-27 14:42:06.698+07	2025-07-27 14:42:06.698+07	1
5	2025-07-29 18:07:39.209+07	1	TIK200_07	f	1	M4455ZZ	1	2025-07-29 18:07:45.957+07	1	1	f	\N	\N	1	0	\N	0	0	1	Sistem otomatis	1	2025-07-30 07:33:19.323+07	2025-07-30 07:33:19.323+07	1
6	2025-07-21 07:00:00+07	1	C101	f	1	B1234XYZ	1	2025-07-21 10:00:00+07	1	1	f	1	t	1	0	\N	0	0	3	Transaksi biasa	\N	2025-07-30 18:31:20.504+07	2025-07-30 18:31:20.504+07	1
7	2025-07-22 08:00:00+07	1	C102	f	1	D5678ABC	1	2025-07-22 11:30:00+07	1	1	f	1	t	1	0	\N	0	0	4	Casual regular	\N	2025-07-30 18:32:41.522+07	2025-07-30 18:32:41.522+07	1
8	2025-07-23 09:00:00+07	1	C103	f	1	F1212ZZ	1	2025-07-23 13:00:00+07	1	1	f	1	t	1	0	\N	0	0	4	Voucher promo casual	\N	2025-07-30 18:33:34.046+07	2025-07-30 18:33:34.046+07	1
9	2025-07-27 06:00:00+07	1	C104	f	1	B1234XYZ	1	2025-07-27 09:00:00+07	1	1	f	1	t	1	0	\N	0	0	3	Check out akhir pekan	\N	2025-07-30 18:33:51.098+07	2025-07-30 18:33:51.098+07	1
10	2025-07-29 07:30:00+07	1	C105	f	1	D5678ABC	1	2025-07-29 11:00:00+07	1	1	f	1	t	2	0	\N	0	0	4	Transaksi casual	\N	2025-07-30 18:34:18.872+07	2025-07-30 18:34:18.872+07	1
11	2025-08-02 06:45:00+07	1	C106	f	1	F1212ZZ	1	2025-08-02 09:45:00+07	1	1	f	1	t	3	0	\N	0	0	3	Voucher akhir bulan	\N	2025-07-30 18:34:37.801+07	2025-07-30 18:34:37.801+07	1
28	2025-07-31 06:45:00+07	1	BATAL531	f	1	F9988XY	1	2025-07-31 09:45:00+07	1	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 10:45:45.021+07	2025-07-31 10:45:45.021+07	1
29	2025-07-31 06:45:00+07	1	BATAL5uuu	f	1	F9988iii	1	2025-07-31 09:45:00+07	1	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 13:19:33.214+07	2025-07-31 13:19:33.214+07	1
30	2025-08-01 06:45:00+07	1	BATAL5uuu	f	1	F9988iii	1	2025-08-31 09:45:00+07	1	1	f	1	f	3	0	2	0	0	723	Dibatalkan karena sistem error	\N	2025-07-31 13:26:45.08+07	2025-07-31 13:26:45.08+07	1
31	2025-07-31 06:45:00+07	1	BATAL531	f	1	F9988XY	1	2025-07-31 09:45:00+07	1	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 13:29:44.885+07	2025-07-31 13:29:44.885+07	1
32	2025-07-31 06:45:00+07	1	BATAL539	f	1	F998XY	1	2025-07-31 09:45:00+07	1	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 13:37:40.315+07	2025-07-31 13:37:40.315+07	1
33	2025-07-31 06:45:00+07	1	BATAL5397	f	1	F998XY7	1	2025-07-31 09:45:00+07	7	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 13:44:50.034+07	2025-07-31 13:44:50.034+07	1
34	2025-07-31 06:45:00+07	1	BATAL5398	f	1	F998XY7	1	2025-07-31 09:45:00+07	8	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 13:45:05.784+07	2025-07-31 13:45:05.784+07	1
35	2025-07-31 06:45:00+07	1	BATAL5398	f	1	F998XY7	1	2025-07-31 09:45:00+07	8	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:22:24.178+07	2025-07-31 16:22:24.178+07	1
38	2025-07-31 07:15:00+07	1	BATAL5400	f	1	D456CD2	1	2025-07-31 10:15:00+07	8	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:23:46.476+07	2025-07-31 16:23:46.476+07	1
39	2025-07-31 07:30:00+07	1	BATAL5401	f	1	E789EF3	1	2025-07-31 10:30:00+07	11	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:24:00.452+07	2025-07-31 16:24:00.452+07	1
40	2025-07-31 07:45:00+07	1	BATAL5402	f	1	F112GH4	1	2025-07-31 10:45:00+07	12	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:24:22.124+07	2025-07-31 16:24:22.124+07	1
41	2025-07-31 07:45:00+07	1	BATAL5402	f	1	F112GH4	1	2025-07-31 10:45:00+07	12	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:24:40.547+07	2025-07-31 16:24:40.547+07	1
42	2025-07-31 08:15:00+07	1	BATAL5404	f	1	H334KL6	1	2025-07-31 11:15:00+07	14	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:24:52.466+07	2025-07-31 16:24:52.466+07	1
43	2025-07-31 08:30:00+07	1	BATAL5405	f	1	J445MN7	1	2025-07-31 11:30:00+07	15	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:25:08.751+07	2025-07-31 16:25:08.751+07	1
44	2025-07-31 08:45:00+07	1	BATAL5406	f	1	K556OP8	1	2025-07-31 11:45:00+07	16	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:25:18.601+07	2025-07-31 16:25:18.601+07	1
45	2025-07-31 09:00:00+07	1	BATAL5407	f	1	L667QR9	1	2025-07-31 12:00:00+07	17	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:25:29.145+07	2025-07-31 16:25:29.145+07	1
46	2025-07-31 09:00:00+07	2	BATAL5407	f	1	L667QR9	1	2025-07-31 12:00:00+07	17	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:26:38.441+07	2025-07-31 16:26:38.441+07	1
47	2025-07-31 09:00:00+07	2	BATAL5407	f	1	L667QR9	1	2025-07-31 12:00:00+07	18	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:27:02.421+07	2025-07-31 16:27:02.421+07	1
48	2025-07-31 09:00:00+07	2	BATAL5407	f	1	L667QR9	1	2025-07-31 12:00:00+07	19	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:27:08.879+07	2025-07-31 16:27:08.879+07	1
49	2025-07-31 09:00:00+07	2	BATAL5407	f	1	L667QR9	1	2025-07-31 12:00:00+07	20	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:27:14.417+07	2025-07-31 16:27:14.417+07	1
50	2025-07-31 09:00:00+07	2	BATAL5407	f	1	L667QR9	1	2025-07-31 12:00:00+07	21	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:27:19.429+07	2025-07-31 16:27:19.429+07	1
51	2025-07-31 09:00:00+07	2	BATAL5407	f	1	L667QR9	1	2025-07-31 12:00:00+07	22	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:27:24.121+07	2025-07-31 16:27:24.121+07	1
52	2025-07-31 09:00:00+07	2	BATAL5407	f	1	L667QR9	1	2025-07-31 12:00:00+07	23	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:27:29.932+07	2025-07-31 16:27:29.932+07	1
53	2025-07-31 09:00:00+07	2	BATAL5407	f	1	L667QR9	1	2025-07-31 12:00:00+07	24	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:27:47.893+07	2025-07-31 16:27:47.893+07	1
54	2025-07-31 09:00:00+07	2	BATAL5407	f	1	L667QR9	1	2025-07-31 12:00:00+07	25	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:27:54.523+07	2025-07-31 16:27:54.523+07	1
55	2025-07-31 09:00:00+07	2	BATAL5407	f	1	L667QR9	1	2025-07-31 12:00:00+07	26	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 16:27:56.963+07	2025-07-31 16:27:56.963+07	1
59	2025-07-31 09:00:00+07	2	TIK099_44	f	1	L667QR9	1	2025-07-31 12:00:00+07	25	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	\N	2025-07-31 20:49:41.999+07	2025-07-31 20:49:41.999+07	1
60	2025-07-31 09:00:00+07	2	TIK099_43	t	1	L667QR9	1	2025-07-31 12:00:00+07	25	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	1	2025-07-31 20:51:04.316+07	2025-07-31 20:51:04.316+07	1
61	2025-07-31 09:00:00+07	2	TIK099_43	f	1	L667QR9	1	2025-07-31 12:00:00+07	25	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	1	2025-07-31 20:53:44.056+07	2025-07-31 20:53:44.056+07	1
62	2025-07-31 09:00:00+07	2	TIK099_40	f	1	L667QR9	1	2025-07-31 12:00:00+07	25	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	1	2025-07-31 20:54:29.031+07	2025-07-31 20:54:29.031+07	1
63	2025-07-31 09:00:00+07	2	TIK099_40	f	1	L667QR9	1	2025-07-31 12:00:00+07	25	1	f	1	f	3	0	2	0	0	3	Dibatalkan karena sistem error	1	2025-07-31 20:54:33.011+07	2025-07-31 20:54:33.011+07	1
65	2025-07-31 09:00:00+07	2	TIK101	f	1	M1011LL	1	2025-07-31 12:00:00+07	25	1	t	1	f	3	987000	2	0	0	3	Dibatalkan karena sistem error	1	2025-08-01 08:44:52.771+07	2025-08-01 08:44:52.771+07	1
66	2025-07-31 09:00:00+07	2	TIK101	f	1	M1011LL	1	2025-07-31 12:00:00+07	25	1	t	1	t	3	0	2	78	990	3	\N	1	2025-08-01 08:45:31.799+07	2025-08-01 08:45:31.799+07	1
67	2025-07-31 09:00:00+07	2	TIK099_44	f	1	B0317OO	1	2025-07-31 12:00:00+07	25	1	t	1	t	3	0	2	0	0	3	\N	1	2025-08-01 17:08:34.59+07	2025-08-01 17:08:34.59+07	1
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, nama, jenis_kelamin, no_hp, alamat_lengkap, username, password, perusahaan_id, level_pengguna_id, status, added_by, "createdAt", "updatedAt", tenant_id) FROM stdin;
1	Evosist	Laki-laki	0823234234234	Jakarta	admin	$argon2id$v=19$m=65536,t=3,p=4$j2sz6NfBRA03j1ODC9R3tg$+CxW5tZjrRknmCehj0Q23uqs7XzmE0wqdMzP9UEktg0	1	1	t	\N	2025-07-24 16:10:38.658+07	2025-07-24 16:10:38.658+07	1
7	Andi	Laki-laki	081347652938	Komplek Bumi Indah, Semarang	anitapwerm	$argon2id$v=19$m=65536,t=3,p=4$mAFQZ5rId8MvFvZObRGK2w$SGyAKasd9XDj0TDgS+WF5aS4EiF9kggeRpHugHtN5ok	1	\N	f	1	2025-07-31 13:43:34.023+07	2025-07-31 13:43:34.023+07	1
8	Budi	Laki-laki	081347652938	Komplek Bumi Indah, Semarang	budi	$argon2id$v=19$m=65536,t=3,p=4$DrB1VWu5N4GHpKJumhiQAg$W7E/nXmXRM/ICyDxdz6iKP5KU9LGm7jKwQ0ayGZco5I	1	\N	f	1	2025-07-31 13:43:57.185+07	2025-07-31 13:43:57.185+07	1
10	Rina	Perempuan	081347652940	Komplek Bumi Indah, Semarang	rina	$argon2id$v=19$m=65536,t=3,p=4$37iWNE9djHMme9NEOo8jrw$WZd3W0oYj9vJxeZHad/56t1AefFjFE4FDNy1YMzx6Zc	1	\N	f	1	2025-07-31 16:02:43.537+07	2025-07-31 16:02:43.537+07	1
11	Dedi	Laki-laki	081347652941	Komplek Bumi Indah, Semarang	dedi	$argon2id$v=19$m=65536,t=3,p=4$0Ud2FEzFFLv4H3ZqJ9A+0Q$7xPm1tTPeyMgvCoOIaIDQOvK/wqqofGJutwqAxou0/o	1	\N	f	1	2025-07-31 16:02:59.287+07	2025-07-31 16:02:59.287+07	1
12	Joko	Laki-laki	081347652943	Komplek Bumi Indah, Semarang	joko	$argon2id$v=19$m=65536,t=3,p=4$wjIBO8lVFA1RsKXPSNSP8g$HG4lY5lVlhTF47jMWYnGJe/xf1uVd88BHybvw32+CiA	1	\N	f	1	2025-07-31 16:03:27.967+07	2025-07-31 16:03:27.967+07	1
13	Lina	Perempuan	081347652944	Komplek Bumi Indah, Semarang	lina	$argon2id$v=19$m=65536,t=3,p=4$aaVLX/tvvf/5AyPemkFULA$q2xQnms6G+i+UVecY7NZidA2LsU01c3lLjXubduWUZ8	1	\N	f	1	2025-07-31 16:03:39.702+07	2025-07-31 16:03:39.702+07	1
14	Agus	Laki-laki	081347652945	Komplek Bumi Indah, Semarang	agus	$argon2id$v=19$m=65536,t=3,p=4$bCazq+8wS97rYLrlSB/1YA$E4OWjAjh3lHd3Xi5FdgYrphHcTKPFf6pKuhN4+0zJJ0	1	\N	f	1	2025-07-31 16:03:49.576+07	2025-07-31 16:03:49.576+07	1
15	Tina	Perempuan	081347652946	Komplek Bumi Indah, Semarang	tina	$argon2id$v=19$m=65536,t=3,p=4$xKpm+4ELQCzMxX2k1eHmIA$/CmjpniGWpn6P96jCTNK/UAreUWO48H2UGMQgYbHjAM	1	\N	f	1	2025-07-31 16:03:59.049+07	2025-07-31 16:03:59.049+07	1
16	Hendra	Laki-laki	081347652947	Komplek Bumi Indah, Semarang	hendra	$argon2id$v=19$m=65536,t=3,p=4$m3iFL9U1NRt0cUPT0ottzQ$oYikb+1FMe4ot2zvGxLMTKa2v6dJP3mHKQHFxK3GFRY	1	\N	f	1	2025-07-31 16:04:08.134+07	2025-07-31 16:04:08.134+07	1
17	Dina	Perempuan	081347652948	Komplek Bumi Indah, Semarang	dina	$argon2id$v=19$m=65536,t=3,p=4$0HzWKLJmQyiHXpgg1Dn8mg$4cwd6PVgUEQl89zeCFMwm1yxkNZVglqOk68tjmxGuT4	1	\N	f	1	2025-07-31 16:04:17.128+07	2025-07-31 16:04:17.128+07	1
18	Rudi	Laki-laki	081347652949	Komplek Bumi Indah, Semarang	rudi	$argon2id$v=19$m=65536,t=3,p=4$nhjCTnRq3S+GXRM0IaqxOA$YqJj+yI333vCPABKsMxBK10m0pXZ9NmOd93SGPtxi+A	1	\N	f	1	2025-07-31 16:04:35.508+07	2025-07-31 16:04:35.508+07	1
19	Wati	Perempuan	081347652950	Komplek Bumi Indah, Semarang	wati	$argon2id$v=19$m=65536,t=3,p=4$rkAu2RuhOa3MVGieQu8g9A$e29JOzAVCv+SAIv8huySqaOqMgPlk8v4bNqyZtU8ERA	1	\N	f	1	2025-07-31 16:04:47.881+07	2025-07-31 16:04:47.881+07	1
20	Ardi	Laki-laki	081347652951	Komplek Bumi Indah, Semarang	ardi	$argon2id$v=19$m=65536,t=3,p=4$c4IOf+d+d9oCcdiTlvpznQ$wz6GbOZvTGEhj7BwXV8KRf2SAS3xKHgYmnR+2tDncJM	1	\N	f	1	2025-07-31 16:05:00.406+07	2025-07-31 16:05:00.406+07	1
21	Sari	Perempuan	081347652952	Komplek Bumi Indah, Semarang	sari	$argon2id$v=19$m=65536,t=3,p=4$hgi69Bzxh0C0Qn8Id0OhCQ$7dABbG23cKVgtkqYUd7Px7AjDpysLR4yTP8KRSL9Af0	1	\N	f	1	2025-07-31 16:05:08.641+07	2025-07-31 16:05:08.641+07	1
22	Nina	Perempuan	081347652953	Komplek Bumi Indah, Semarang	nina	$argon2id$v=19$m=65536,t=3,p=4$UcCDflGO2PRh/X+4Mrpnfg$duDbV0xzSiBjnpKGOqODlLf2DBz0kV2Kstk5ktK2KyY	1	\N	f	1	2025-07-31 16:07:17.732+07	2025-07-31 16:07:17.732+07	1
23	Bayu	Laki-laki	081347652954	Komplek Bumi Indah, Semarang	bayu	$argon2id$v=19$m=65536,t=3,p=4$N63Rp21xByksaXRBiX4B0w$Weha/onaz/uRZ6zMHKrgZzfawojYzRb6R4IoCA886+I	1	\N	f	1	2025-07-31 16:07:35.665+07	2025-07-31 16:07:35.665+07	1
24	Yuni	Perempuan	081347652955	Komplek Bumi Indah, Semarang	yuni	$argon2id$v=19$m=65536,t=3,p=4$qt0WlX8NY9yRjQnidGePwA$H2hJu2Yut6HoCiJvDMScCmyFTnU6L9t3ThlNGUJoRtA	1	\N	f	1	2025-07-31 16:07:46.298+07	2025-07-31 16:07:46.298+07	1
25	Dimas	Laki-laki	081347652956	Komplek Bumi Indah, Semarang	dimas	$argon2id$v=19$m=65536,t=3,p=4$2KGtrSzBAunH95Z82M7crw$liCfuTOhbsoFdTzc74TbjLb/hZwpSmAEFsZhg72mXv0	1	\N	f	1	2025-07-31 16:07:54.995+07	2025-07-31 16:07:54.995+07	1
26	Mega	Perempuan	081347652957	Komplek Bumi Indah, Semarang	mega	$argon2id$v=19$m=65536,t=3,p=4$kv50LP+n4TaJBGlr3cyrQg$9EOX4xZP8y3oseEVuJ3OL690e0kWUd8xzV8i/yd9ors	1	\N	f	1	2025-07-31 16:08:05.621+07	2025-07-31 16:08:05.621+07	1
29	Andi S	Laki-laki	999910	akjakj	andi s	$argon2id$v=19$m=65536,t=3,p=4$a0AQrpatLbHOKmi94wRHuQ$ol5AFfbPi2QiTs+nzng62uPbXlZZfAt412n9Q48FPkM	19	9	t	1	2025-08-02 14:11:37.941+07	2025-08-02 14:11:37.941+07	1
\.


--
-- Name: aktivitas_gerbang_kendaraans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aktivitas_gerbang_kendaraans_id_seq', 195, true);


--
-- Name: data_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.data_members_id_seq', 41, true);


--
-- Name: data_nomor_polisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.data_nomor_polisis_id_seq', 56, true);


--
-- Name: data_vouchers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.data_vouchers_id_seq', 6, true);


--
-- Name: global_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.global_settings_id_seq', 1, true);


--
-- Name: kendaraans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kendaraans_id_seq', 36, true);


--
-- Name: laporan_riwayat_transaksi_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.laporan_riwayat_transaksi_members_id_seq', 1, false);


--
-- Name: laporan_transaksi_batals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.laporan_transaksi_batals_id_seq', 7, true);


--
-- Name: level_penggunas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.level_penggunas_id_seq', 20, true);


--
-- Name: nama_interfaces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nama_interfaces_id_seq', 1, true);


--
-- Name: nama_printers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nama_printers_id_seq', 1, true);


--
-- Name: parameters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parameters_id_seq', 1, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 6, true);


--
-- Name: permasalahan_atau_perbaikans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permasalahan_atau_perbaikans_id_seq', 1, true);


--
-- Name: perusahaans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perusahaans_id_seq', 20, true);


--
-- Name: pos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pos_id_seq', 18, true);


--
-- Name: produk_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produk_members_id_seq', 26, true);


--
-- Name: produk_vouchers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produk_vouchers_id_seq', 5, true);


--
-- Name: riwayat_ganti_nomor_polisi_v2_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.riwayat_ganti_nomor_polisi_v2_id_seq', 1, false);


--
-- Name: riwayat_transaksi_ganti_nopols_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.riwayat_transaksi_ganti_nopols_id_seq', 1, false);


--
-- Name: riwayat_transaksi_kartu_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.riwayat_transaksi_kartu_members_id_seq', 1, false);


--
-- Name: riwayat_transaksi_member_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.riwayat_transaksi_member_id_seq', 1, false);


--
-- Name: shifts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shifts_id_seq', 1, true);


--
-- Name: tarif_dendas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tarif_dendas_id_seq', 3, true);


--
-- Name: tarif_parkirs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tarif_parkirs_id_seq', 29, true);


--
-- Name: tenants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tenants_id_seq', 1, true);


--
-- Name: tipe_dendas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipe_dendas_id_seq', 1, true);


--
-- Name: tipe_kendaraans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipe_kendaraans_id_seq', 16, true);


--
-- Name: tipe_manlesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipe_manlesses_id_seq', 1, true);


--
-- Name: transaksis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaksis_id_seq', 67, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 29, true);


--
-- Name: aktivitas_gerbang_kendaraans aktivitas_gerbang_kendaraans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aktivitas_gerbang_kendaraans
    ADD CONSTRAINT aktivitas_gerbang_kendaraans_pkey PRIMARY KEY (id);


--
-- Name: data_members data_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_members
    ADD CONSTRAINT data_members_pkey PRIMARY KEY (id);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key1 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key10 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key100 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key101 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key102 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key103 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key104 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key105 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key106 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key107; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key107 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key108; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key108 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key109; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key109 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key11 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key110; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key110 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key111; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key111 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key112; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key112 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key113; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key113 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key114; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key114 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key115; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key115 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key116; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key116 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key117; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key117 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key118; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key118 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key119; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key119 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key12 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key120; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key120 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key121; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key121 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key122; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key122 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key123; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key123 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key124; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key124 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key125; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key125 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key126; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key126 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key127; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key127 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key128; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key128 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key129; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key129 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key13 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key130; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key130 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key131; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key131 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key132; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key132 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key133; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key133 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key134; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key134 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key135; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key135 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key136; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key136 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key137; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key137 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key138; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key138 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key139; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key139 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key14 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key140; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key140 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key141; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key141 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key142; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key142 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key143; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key143 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key144; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key144 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key145; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key145 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key146; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key146 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key147; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key147 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key148; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key148 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key149; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key149 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key15 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key150; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key150 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key151; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key151 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key152; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key152 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key153; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key153 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key154; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key154 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key155; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key155 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key156; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key156 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key157; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key157 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key158; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key158 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key16 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key17 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key18 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key19 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key2 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key20 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key21 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key22 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key23 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key24 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key25 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key26 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key27 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key28 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key29 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key3 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key30 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key31 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key32 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key33 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key34 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key35 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key36 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key37 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key38 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key39 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key4 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key40 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key41 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key42 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key43 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key44 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key45 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key46 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key47 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key48 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key49 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key5 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key50 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key51 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key52 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key53 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key54 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key55 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key56 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key57 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key58 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key59 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key6 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key60 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key61 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key62 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key63 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key64 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key65 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key66 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key67 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key68 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key69 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key7 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key70 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key71 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key72 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key73 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key74 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key75 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key76 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key77 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key78 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key79 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key8 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key80 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key81 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key82 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key83 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key84 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key85 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key86 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key87 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key88 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key89 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key9 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key90 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key91 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key92 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key93 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key94 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key95 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key96 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key97 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key98 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key99 UNIQUE (nomor_polisi);


--
-- Name: data_nomor_polisis data_nomor_polisis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_pkey PRIMARY KEY (id);


--
-- Name: data_vouchers data_vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_vouchers
    ADD CONSTRAINT data_vouchers_pkey PRIMARY KEY (id);


--
-- Name: global_settings global_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_settings
    ADD CONSTRAINT global_settings_pkey PRIMARY KEY (id);


--
-- Name: kendaraans kendaraans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kendaraans
    ADD CONSTRAINT kendaraans_pkey PRIMARY KEY (id);


--
-- Name: laporan_riwayat_transaksi_members laporan_riwayat_transaksi_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_riwayat_transaksi_members
    ADD CONSTRAINT laporan_riwayat_transaksi_members_pkey PRIMARY KEY (id);


--
-- Name: laporan_transaksi_batals laporan_transaksi_batals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_transaksi_batals
    ADD CONSTRAINT laporan_transaksi_batals_pkey PRIMARY KEY (id);


--
-- Name: level_penggunas level_penggunas_nama_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key1 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key10 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key100 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key101 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key102 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key103 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key104 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key105 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key106 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key107; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key107 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key108; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key108 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key109; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key109 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key11 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key110; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key110 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key111; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key111 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key112; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key112 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key113; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key113 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key114; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key114 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key115; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key115 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key116; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key116 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key117; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key117 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key118; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key118 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key119; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key119 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key12 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key120; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key120 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key121; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key121 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key122; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key122 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key123; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key123 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key124; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key124 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key125; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key125 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key126; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key126 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key127; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key127 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key128; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key128 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key129; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key129 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key13 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key130; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key130 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key131; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key131 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key132; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key132 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key133; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key133 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key134; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key134 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key135; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key135 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key136; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key136 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key137; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key137 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key138; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key138 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key139; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key139 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key14 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key140; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key140 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key141; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key141 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key142; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key142 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key143; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key143 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key144; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key144 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key145; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key145 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key146; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key146 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key147; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key147 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key148; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key148 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key149; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key149 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key15 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key150; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key150 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key151; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key151 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key152; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key152 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key153; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key153 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key154; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key154 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key155; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key155 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key156; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key156 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key157; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key157 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key158; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key158 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key16 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key17 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key18 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key19 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key2 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key20 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key21 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key22 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key23 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key24 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key25 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key26 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key27 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key28 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key29 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key3 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key30 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key31 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key32 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key33 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key34 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key35 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key36 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key37 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key38 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key39 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key4 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key40 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key41 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key42 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key43 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key44 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key45 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key46 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key47 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key48 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key49 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key5 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key50 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key51 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key52 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key53 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key54 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key55 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key56 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key57 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key58 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key59 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key6 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key60 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key61 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key62 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key63 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key64 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key65 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key66 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key67 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key68 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key69 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key7 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key70 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key71 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key72 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key73 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key74 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key75 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key76 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key77 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key78 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key79 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key8 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key80 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key81 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key82 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key83 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key84 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key85 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key86 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key87 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key88 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key89 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key9 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key90 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key91 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key92 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key93 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key94 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key95 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key96 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key97 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key98 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_nama_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key99 UNIQUE (nama);


--
-- Name: level_penggunas level_penggunas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_pkey PRIMARY KEY (id);


--
-- Name: nama_interfaces nama_interfaces_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nama_interfaces
    ADD CONSTRAINT nama_interfaces_pkey PRIMARY KEY (id);


--
-- Name: nama_printers nama_printers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nama_printers
    ADD CONSTRAINT nama_printers_pkey PRIMARY KEY (id);


--
-- Name: parameters parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parameters
    ADD CONSTRAINT parameters_pkey PRIMARY KEY (id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: permasalahan_atau_perbaikans permasalahan_atau_perbaikans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permasalahan_atau_perbaikans
    ADD CONSTRAINT permasalahan_atau_perbaikans_pkey PRIMARY KEY (id);


--
-- Name: perusahaans perusahaans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perusahaans
    ADD CONSTRAINT perusahaans_pkey PRIMARY KEY (id);


--
-- Name: pos pos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos
    ADD CONSTRAINT pos_pkey PRIMARY KEY (id);


--
-- Name: produk_members produk_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_members
    ADD CONSTRAINT produk_members_pkey PRIMARY KEY (id);


--
-- Name: produk_vouchers produk_vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_vouchers
    ADD CONSTRAINT produk_vouchers_pkey PRIMARY KEY (id);


--
-- Name: riwayat_ganti_nomor_polisi_v2 riwayat_ganti_nomor_polisi_v2_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_ganti_nomor_polisi_v2
    ADD CONSTRAINT riwayat_ganti_nomor_polisi_v2_pkey PRIMARY KEY (id);


--
-- Name: riwayat_transaksi_ganti_nopols riwayat_transaksi_ganti_nopols_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_ganti_nopols
    ADD CONSTRAINT riwayat_transaksi_ganti_nopols_pkey PRIMARY KEY (id);


--
-- Name: riwayat_transaksi_kartu_members riwayat_transaksi_kartu_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_kartu_members
    ADD CONSTRAINT riwayat_transaksi_kartu_members_pkey PRIMARY KEY (id);


--
-- Name: riwayat_transaksi_member riwayat_transaksi_member_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_member
    ADD CONSTRAINT riwayat_transaksi_member_pkey PRIMARY KEY (id);


--
-- Name: shifts shifts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shifts
    ADD CONSTRAINT shifts_pkey PRIMARY KEY (id);


--
-- Name: tarif_dendas tarif_dendas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_dendas
    ADD CONSTRAINT tarif_dendas_pkey PRIMARY KEY (id);


--
-- Name: tarif_parkirs tarif_parkirs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_parkirs
    ADD CONSTRAINT tarif_parkirs_pkey PRIMARY KEY (id);


--
-- Name: tenants tenants_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tenants
    ADD CONSTRAINT tenants_pkey PRIMARY KEY (id);


--
-- Name: tipe_dendas tipe_dendas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_dendas
    ADD CONSTRAINT tipe_dendas_pkey PRIMARY KEY (id);


--
-- Name: tipe_kendaraans tipe_kendaraans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_kendaraans
    ADD CONSTRAINT tipe_kendaraans_pkey PRIMARY KEY (id);


--
-- Name: tipe_manlesses tipe_manlesses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_manlesses
    ADD CONSTRAINT tipe_manlesses_pkey PRIMARY KEY (id);


--
-- Name: transaksis transaksis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_pkey PRIMARY KEY (id);


--
-- Name: users users_nama_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key UNIQUE (nama);


--
-- Name: users users_nama_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key1 UNIQUE (nama);


--
-- Name: users users_nama_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key10 UNIQUE (nama);


--
-- Name: users users_nama_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key100 UNIQUE (nama);


--
-- Name: users users_nama_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key101 UNIQUE (nama);


--
-- Name: users users_nama_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key102 UNIQUE (nama);


--
-- Name: users users_nama_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key103 UNIQUE (nama);


--
-- Name: users users_nama_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key104 UNIQUE (nama);


--
-- Name: users users_nama_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key105 UNIQUE (nama);


--
-- Name: users users_nama_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key106 UNIQUE (nama);


--
-- Name: users users_nama_key107; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key107 UNIQUE (nama);


--
-- Name: users users_nama_key108; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key108 UNIQUE (nama);


--
-- Name: users users_nama_key109; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key109 UNIQUE (nama);


--
-- Name: users users_nama_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key11 UNIQUE (nama);


--
-- Name: users users_nama_key110; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key110 UNIQUE (nama);


--
-- Name: users users_nama_key111; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key111 UNIQUE (nama);


--
-- Name: users users_nama_key112; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key112 UNIQUE (nama);


--
-- Name: users users_nama_key113; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key113 UNIQUE (nama);


--
-- Name: users users_nama_key114; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key114 UNIQUE (nama);


--
-- Name: users users_nama_key115; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key115 UNIQUE (nama);


--
-- Name: users users_nama_key116; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key116 UNIQUE (nama);


--
-- Name: users users_nama_key117; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key117 UNIQUE (nama);


--
-- Name: users users_nama_key118; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key118 UNIQUE (nama);


--
-- Name: users users_nama_key119; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key119 UNIQUE (nama);


--
-- Name: users users_nama_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key12 UNIQUE (nama);


--
-- Name: users users_nama_key120; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key120 UNIQUE (nama);


--
-- Name: users users_nama_key121; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key121 UNIQUE (nama);


--
-- Name: users users_nama_key122; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key122 UNIQUE (nama);


--
-- Name: users users_nama_key123; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key123 UNIQUE (nama);


--
-- Name: users users_nama_key124; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key124 UNIQUE (nama);


--
-- Name: users users_nama_key125; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key125 UNIQUE (nama);


--
-- Name: users users_nama_key126; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key126 UNIQUE (nama);


--
-- Name: users users_nama_key127; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key127 UNIQUE (nama);


--
-- Name: users users_nama_key128; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key128 UNIQUE (nama);


--
-- Name: users users_nama_key129; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key129 UNIQUE (nama);


--
-- Name: users users_nama_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key13 UNIQUE (nama);


--
-- Name: users users_nama_key130; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key130 UNIQUE (nama);


--
-- Name: users users_nama_key131; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key131 UNIQUE (nama);


--
-- Name: users users_nama_key132; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key132 UNIQUE (nama);


--
-- Name: users users_nama_key133; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key133 UNIQUE (nama);


--
-- Name: users users_nama_key134; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key134 UNIQUE (nama);


--
-- Name: users users_nama_key135; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key135 UNIQUE (nama);


--
-- Name: users users_nama_key136; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key136 UNIQUE (nama);


--
-- Name: users users_nama_key137; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key137 UNIQUE (nama);


--
-- Name: users users_nama_key138; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key138 UNIQUE (nama);


--
-- Name: users users_nama_key139; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key139 UNIQUE (nama);


--
-- Name: users users_nama_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key14 UNIQUE (nama);


--
-- Name: users users_nama_key140; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key140 UNIQUE (nama);


--
-- Name: users users_nama_key141; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key141 UNIQUE (nama);


--
-- Name: users users_nama_key142; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key142 UNIQUE (nama);


--
-- Name: users users_nama_key143; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key143 UNIQUE (nama);


--
-- Name: users users_nama_key144; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key144 UNIQUE (nama);


--
-- Name: users users_nama_key145; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key145 UNIQUE (nama);


--
-- Name: users users_nama_key146; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key146 UNIQUE (nama);


--
-- Name: users users_nama_key147; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key147 UNIQUE (nama);


--
-- Name: users users_nama_key148; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key148 UNIQUE (nama);


--
-- Name: users users_nama_key149; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key149 UNIQUE (nama);


--
-- Name: users users_nama_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key15 UNIQUE (nama);


--
-- Name: users users_nama_key150; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key150 UNIQUE (nama);


--
-- Name: users users_nama_key151; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key151 UNIQUE (nama);


--
-- Name: users users_nama_key152; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key152 UNIQUE (nama);


--
-- Name: users users_nama_key153; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key153 UNIQUE (nama);


--
-- Name: users users_nama_key154; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key154 UNIQUE (nama);


--
-- Name: users users_nama_key155; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key155 UNIQUE (nama);


--
-- Name: users users_nama_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key16 UNIQUE (nama);


--
-- Name: users users_nama_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key17 UNIQUE (nama);


--
-- Name: users users_nama_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key18 UNIQUE (nama);


--
-- Name: users users_nama_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key19 UNIQUE (nama);


--
-- Name: users users_nama_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key2 UNIQUE (nama);


--
-- Name: users users_nama_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key20 UNIQUE (nama);


--
-- Name: users users_nama_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key21 UNIQUE (nama);


--
-- Name: users users_nama_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key22 UNIQUE (nama);


--
-- Name: users users_nama_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key23 UNIQUE (nama);


--
-- Name: users users_nama_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key24 UNIQUE (nama);


--
-- Name: users users_nama_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key25 UNIQUE (nama);


--
-- Name: users users_nama_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key26 UNIQUE (nama);


--
-- Name: users users_nama_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key27 UNIQUE (nama);


--
-- Name: users users_nama_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key28 UNIQUE (nama);


--
-- Name: users users_nama_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key29 UNIQUE (nama);


--
-- Name: users users_nama_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key3 UNIQUE (nama);


--
-- Name: users users_nama_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key30 UNIQUE (nama);


--
-- Name: users users_nama_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key31 UNIQUE (nama);


--
-- Name: users users_nama_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key32 UNIQUE (nama);


--
-- Name: users users_nama_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key33 UNIQUE (nama);


--
-- Name: users users_nama_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key34 UNIQUE (nama);


--
-- Name: users users_nama_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key35 UNIQUE (nama);


--
-- Name: users users_nama_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key36 UNIQUE (nama);


--
-- Name: users users_nama_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key37 UNIQUE (nama);


--
-- Name: users users_nama_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key38 UNIQUE (nama);


--
-- Name: users users_nama_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key39 UNIQUE (nama);


--
-- Name: users users_nama_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key4 UNIQUE (nama);


--
-- Name: users users_nama_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key40 UNIQUE (nama);


--
-- Name: users users_nama_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key41 UNIQUE (nama);


--
-- Name: users users_nama_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key42 UNIQUE (nama);


--
-- Name: users users_nama_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key43 UNIQUE (nama);


--
-- Name: users users_nama_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key44 UNIQUE (nama);


--
-- Name: users users_nama_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key45 UNIQUE (nama);


--
-- Name: users users_nama_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key46 UNIQUE (nama);


--
-- Name: users users_nama_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key47 UNIQUE (nama);


--
-- Name: users users_nama_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key48 UNIQUE (nama);


--
-- Name: users users_nama_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key49 UNIQUE (nama);


--
-- Name: users users_nama_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key5 UNIQUE (nama);


--
-- Name: users users_nama_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key50 UNIQUE (nama);


--
-- Name: users users_nama_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key51 UNIQUE (nama);


--
-- Name: users users_nama_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key52 UNIQUE (nama);


--
-- Name: users users_nama_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key53 UNIQUE (nama);


--
-- Name: users users_nama_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key54 UNIQUE (nama);


--
-- Name: users users_nama_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key55 UNIQUE (nama);


--
-- Name: users users_nama_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key56 UNIQUE (nama);


--
-- Name: users users_nama_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key57 UNIQUE (nama);


--
-- Name: users users_nama_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key58 UNIQUE (nama);


--
-- Name: users users_nama_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key59 UNIQUE (nama);


--
-- Name: users users_nama_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key6 UNIQUE (nama);


--
-- Name: users users_nama_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key60 UNIQUE (nama);


--
-- Name: users users_nama_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key61 UNIQUE (nama);


--
-- Name: users users_nama_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key62 UNIQUE (nama);


--
-- Name: users users_nama_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key63 UNIQUE (nama);


--
-- Name: users users_nama_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key64 UNIQUE (nama);


--
-- Name: users users_nama_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key65 UNIQUE (nama);


--
-- Name: users users_nama_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key66 UNIQUE (nama);


--
-- Name: users users_nama_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key67 UNIQUE (nama);


--
-- Name: users users_nama_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key68 UNIQUE (nama);


--
-- Name: users users_nama_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key69 UNIQUE (nama);


--
-- Name: users users_nama_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key7 UNIQUE (nama);


--
-- Name: users users_nama_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key70 UNIQUE (nama);


--
-- Name: users users_nama_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key71 UNIQUE (nama);


--
-- Name: users users_nama_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key72 UNIQUE (nama);


--
-- Name: users users_nama_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key73 UNIQUE (nama);


--
-- Name: users users_nama_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key74 UNIQUE (nama);


--
-- Name: users users_nama_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key75 UNIQUE (nama);


--
-- Name: users users_nama_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key76 UNIQUE (nama);


--
-- Name: users users_nama_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key77 UNIQUE (nama);


--
-- Name: users users_nama_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key78 UNIQUE (nama);


--
-- Name: users users_nama_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key79 UNIQUE (nama);


--
-- Name: users users_nama_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key8 UNIQUE (nama);


--
-- Name: users users_nama_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key80 UNIQUE (nama);


--
-- Name: users users_nama_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key81 UNIQUE (nama);


--
-- Name: users users_nama_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key82 UNIQUE (nama);


--
-- Name: users users_nama_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key83 UNIQUE (nama);


--
-- Name: users users_nama_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key84 UNIQUE (nama);


--
-- Name: users users_nama_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key85 UNIQUE (nama);


--
-- Name: users users_nama_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key86 UNIQUE (nama);


--
-- Name: users users_nama_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key87 UNIQUE (nama);


--
-- Name: users users_nama_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key88 UNIQUE (nama);


--
-- Name: users users_nama_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key89 UNIQUE (nama);


--
-- Name: users users_nama_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key9 UNIQUE (nama);


--
-- Name: users users_nama_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key90 UNIQUE (nama);


--
-- Name: users users_nama_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key91 UNIQUE (nama);


--
-- Name: users users_nama_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key92 UNIQUE (nama);


--
-- Name: users users_nama_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key93 UNIQUE (nama);


--
-- Name: users users_nama_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key94 UNIQUE (nama);


--
-- Name: users users_nama_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key95 UNIQUE (nama);


--
-- Name: users users_nama_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key96 UNIQUE (nama);


--
-- Name: users users_nama_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key97 UNIQUE (nama);


--
-- Name: users users_nama_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key98 UNIQUE (nama);


--
-- Name: users users_nama_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key99 UNIQUE (nama);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- Name: users users_username_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key1 UNIQUE (username);


--
-- Name: users users_username_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key10 UNIQUE (username);


--
-- Name: users users_username_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key100 UNIQUE (username);


--
-- Name: users users_username_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key101 UNIQUE (username);


--
-- Name: users users_username_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key102 UNIQUE (username);


--
-- Name: users users_username_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key103 UNIQUE (username);


--
-- Name: users users_username_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key104 UNIQUE (username);


--
-- Name: users users_username_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key105 UNIQUE (username);


--
-- Name: users users_username_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key106 UNIQUE (username);


--
-- Name: users users_username_key107; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key107 UNIQUE (username);


--
-- Name: users users_username_key108; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key108 UNIQUE (username);


--
-- Name: users users_username_key109; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key109 UNIQUE (username);


--
-- Name: users users_username_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key11 UNIQUE (username);


--
-- Name: users users_username_key110; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key110 UNIQUE (username);


--
-- Name: users users_username_key111; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key111 UNIQUE (username);


--
-- Name: users users_username_key112; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key112 UNIQUE (username);


--
-- Name: users users_username_key113; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key113 UNIQUE (username);


--
-- Name: users users_username_key114; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key114 UNIQUE (username);


--
-- Name: users users_username_key115; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key115 UNIQUE (username);


--
-- Name: users users_username_key116; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key116 UNIQUE (username);


--
-- Name: users users_username_key117; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key117 UNIQUE (username);


--
-- Name: users users_username_key118; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key118 UNIQUE (username);


--
-- Name: users users_username_key119; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key119 UNIQUE (username);


--
-- Name: users users_username_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key12 UNIQUE (username);


--
-- Name: users users_username_key120; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key120 UNIQUE (username);


--
-- Name: users users_username_key121; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key121 UNIQUE (username);


--
-- Name: users users_username_key122; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key122 UNIQUE (username);


--
-- Name: users users_username_key123; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key123 UNIQUE (username);


--
-- Name: users users_username_key124; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key124 UNIQUE (username);


--
-- Name: users users_username_key125; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key125 UNIQUE (username);


--
-- Name: users users_username_key126; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key126 UNIQUE (username);


--
-- Name: users users_username_key127; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key127 UNIQUE (username);


--
-- Name: users users_username_key128; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key128 UNIQUE (username);


--
-- Name: users users_username_key129; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key129 UNIQUE (username);


--
-- Name: users users_username_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key13 UNIQUE (username);


--
-- Name: users users_username_key130; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key130 UNIQUE (username);


--
-- Name: users users_username_key131; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key131 UNIQUE (username);


--
-- Name: users users_username_key132; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key132 UNIQUE (username);


--
-- Name: users users_username_key133; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key133 UNIQUE (username);


--
-- Name: users users_username_key134; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key134 UNIQUE (username);


--
-- Name: users users_username_key135; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key135 UNIQUE (username);


--
-- Name: users users_username_key136; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key136 UNIQUE (username);


--
-- Name: users users_username_key137; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key137 UNIQUE (username);


--
-- Name: users users_username_key138; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key138 UNIQUE (username);


--
-- Name: users users_username_key139; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key139 UNIQUE (username);


--
-- Name: users users_username_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key14 UNIQUE (username);


--
-- Name: users users_username_key140; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key140 UNIQUE (username);


--
-- Name: users users_username_key141; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key141 UNIQUE (username);


--
-- Name: users users_username_key142; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key142 UNIQUE (username);


--
-- Name: users users_username_key143; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key143 UNIQUE (username);


--
-- Name: users users_username_key144; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key144 UNIQUE (username);


--
-- Name: users users_username_key145; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key145 UNIQUE (username);


--
-- Name: users users_username_key146; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key146 UNIQUE (username);


--
-- Name: users users_username_key147; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key147 UNIQUE (username);


--
-- Name: users users_username_key148; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key148 UNIQUE (username);


--
-- Name: users users_username_key149; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key149 UNIQUE (username);


--
-- Name: users users_username_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key15 UNIQUE (username);


--
-- Name: users users_username_key150; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key150 UNIQUE (username);


--
-- Name: users users_username_key151; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key151 UNIQUE (username);


--
-- Name: users users_username_key152; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key152 UNIQUE (username);


--
-- Name: users users_username_key153; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key153 UNIQUE (username);


--
-- Name: users users_username_key154; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key154 UNIQUE (username);


--
-- Name: users users_username_key155; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key155 UNIQUE (username);


--
-- Name: users users_username_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key16 UNIQUE (username);


--
-- Name: users users_username_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key17 UNIQUE (username);


--
-- Name: users users_username_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key18 UNIQUE (username);


--
-- Name: users users_username_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key19 UNIQUE (username);


--
-- Name: users users_username_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key2 UNIQUE (username);


--
-- Name: users users_username_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key20 UNIQUE (username);


--
-- Name: users users_username_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key21 UNIQUE (username);


--
-- Name: users users_username_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key22 UNIQUE (username);


--
-- Name: users users_username_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key23 UNIQUE (username);


--
-- Name: users users_username_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key24 UNIQUE (username);


--
-- Name: users users_username_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key25 UNIQUE (username);


--
-- Name: users users_username_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key26 UNIQUE (username);


--
-- Name: users users_username_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key27 UNIQUE (username);


--
-- Name: users users_username_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key28 UNIQUE (username);


--
-- Name: users users_username_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key29 UNIQUE (username);


--
-- Name: users users_username_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key3 UNIQUE (username);


--
-- Name: users users_username_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key30 UNIQUE (username);


--
-- Name: users users_username_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key31 UNIQUE (username);


--
-- Name: users users_username_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key32 UNIQUE (username);


--
-- Name: users users_username_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key33 UNIQUE (username);


--
-- Name: users users_username_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key34 UNIQUE (username);


--
-- Name: users users_username_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key35 UNIQUE (username);


--
-- Name: users users_username_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key36 UNIQUE (username);


--
-- Name: users users_username_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key37 UNIQUE (username);


--
-- Name: users users_username_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key38 UNIQUE (username);


--
-- Name: users users_username_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key39 UNIQUE (username);


--
-- Name: users users_username_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key4 UNIQUE (username);


--
-- Name: users users_username_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key40 UNIQUE (username);


--
-- Name: users users_username_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key41 UNIQUE (username);


--
-- Name: users users_username_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key42 UNIQUE (username);


--
-- Name: users users_username_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key43 UNIQUE (username);


--
-- Name: users users_username_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key44 UNIQUE (username);


--
-- Name: users users_username_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key45 UNIQUE (username);


--
-- Name: users users_username_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key46 UNIQUE (username);


--
-- Name: users users_username_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key47 UNIQUE (username);


--
-- Name: users users_username_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key48 UNIQUE (username);


--
-- Name: users users_username_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key49 UNIQUE (username);


--
-- Name: users users_username_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key5 UNIQUE (username);


--
-- Name: users users_username_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key50 UNIQUE (username);


--
-- Name: users users_username_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key51 UNIQUE (username);


--
-- Name: users users_username_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key52 UNIQUE (username);


--
-- Name: users users_username_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key53 UNIQUE (username);


--
-- Name: users users_username_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key54 UNIQUE (username);


--
-- Name: users users_username_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key55 UNIQUE (username);


--
-- Name: users users_username_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key56 UNIQUE (username);


--
-- Name: users users_username_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key57 UNIQUE (username);


--
-- Name: users users_username_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key58 UNIQUE (username);


--
-- Name: users users_username_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key59 UNIQUE (username);


--
-- Name: users users_username_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key6 UNIQUE (username);


--
-- Name: users users_username_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key60 UNIQUE (username);


--
-- Name: users users_username_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key61 UNIQUE (username);


--
-- Name: users users_username_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key62 UNIQUE (username);


--
-- Name: users users_username_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key63 UNIQUE (username);


--
-- Name: users users_username_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key64 UNIQUE (username);


--
-- Name: users users_username_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key65 UNIQUE (username);


--
-- Name: users users_username_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key66 UNIQUE (username);


--
-- Name: users users_username_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key67 UNIQUE (username);


--
-- Name: users users_username_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key68 UNIQUE (username);


--
-- Name: users users_username_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key69 UNIQUE (username);


--
-- Name: users users_username_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key7 UNIQUE (username);


--
-- Name: users users_username_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key70 UNIQUE (username);


--
-- Name: users users_username_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key71 UNIQUE (username);


--
-- Name: users users_username_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key72 UNIQUE (username);


--
-- Name: users users_username_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key73 UNIQUE (username);


--
-- Name: users users_username_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key74 UNIQUE (username);


--
-- Name: users users_username_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key75 UNIQUE (username);


--
-- Name: users users_username_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key76 UNIQUE (username);


--
-- Name: users users_username_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key77 UNIQUE (username);


--
-- Name: users users_username_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key78 UNIQUE (username);


--
-- Name: users users_username_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key79 UNIQUE (username);


--
-- Name: users users_username_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key8 UNIQUE (username);


--
-- Name: users users_username_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key80 UNIQUE (username);


--
-- Name: users users_username_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key81 UNIQUE (username);


--
-- Name: users users_username_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key82 UNIQUE (username);


--
-- Name: users users_username_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key83 UNIQUE (username);


--
-- Name: users users_username_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key84 UNIQUE (username);


--
-- Name: users users_username_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key85 UNIQUE (username);


--
-- Name: users users_username_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key86 UNIQUE (username);


--
-- Name: users users_username_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key87 UNIQUE (username);


--
-- Name: users users_username_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key88 UNIQUE (username);


--
-- Name: users users_username_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key89 UNIQUE (username);


--
-- Name: users users_username_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key9 UNIQUE (username);


--
-- Name: users users_username_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key90 UNIQUE (username);


--
-- Name: users users_username_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key91 UNIQUE (username);


--
-- Name: users users_username_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key92 UNIQUE (username);


--
-- Name: users users_username_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key93 UNIQUE (username);


--
-- Name: users users_username_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key94 UNIQUE (username);


--
-- Name: users users_username_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key95 UNIQUE (username);


--
-- Name: users users_username_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key96 UNIQUE (username);


--
-- Name: users users_username_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key97 UNIQUE (username);


--
-- Name: users users_username_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key98 UNIQUE (username);


--
-- Name: users users_username_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key99 UNIQUE (username);


--
-- Name: aktivitas_gerbang_kendaraans aktivitas_gerbang_kendaraans_data_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aktivitas_gerbang_kendaraans
    ADD CONSTRAINT aktivitas_gerbang_kendaraans_data_member_id_fkey FOREIGN KEY (data_member_id) REFERENCES public.data_members(id) ON UPDATE CASCADE;


--
-- Name: aktivitas_gerbang_kendaraans aktivitas_gerbang_kendaraans_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aktivitas_gerbang_kendaraans
    ADD CONSTRAINT aktivitas_gerbang_kendaraans_kendaraan_id_fkey FOREIGN KEY (kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE;


--
-- Name: aktivitas_gerbang_kendaraans aktivitas_gerbang_kendaraans_petugas_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aktivitas_gerbang_kendaraans
    ADD CONSTRAINT aktivitas_gerbang_kendaraans_petugas_id_fkey FOREIGN KEY (petugas_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: aktivitas_gerbang_kendaraans aktivitas_gerbang_kendaraans_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aktivitas_gerbang_kendaraans
    ADD CONSTRAINT aktivitas_gerbang_kendaraans_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: data_members data_members_perusahaan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_members
    ADD CONSTRAINT data_members_perusahaan_id_fkey FOREIGN KEY (perusahaan_id) REFERENCES public.perusahaans(id) ON UPDATE CASCADE;


--
-- Name: data_members data_members_produk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_members
    ADD CONSTRAINT data_members_produk_id_fkey FOREIGN KEY (produk_id) REFERENCES public.produk_members(id) ON UPDATE CASCADE;


--
-- Name: data_members data_members_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_members
    ADD CONSTRAINT data_members_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: data_members data_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_members
    ADD CONSTRAINT data_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: data_nomor_polisis data_nomor_polisis_data_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_data_member_id_fkey FOREIGN KEY (data_member_id) REFERENCES public.data_members(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: data_nomor_polisis data_nomor_polisis_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_kendaraan_id_fkey FOREIGN KEY (kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE;


--
-- Name: data_nomor_polisis data_nomor_polisis_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: data_vouchers data_vouchers_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_vouchers
    ADD CONSTRAINT data_vouchers_kendaraan_id_fkey FOREIGN KEY (kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE;


--
-- Name: data_vouchers data_vouchers_produk_voucher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_vouchers
    ADD CONSTRAINT data_vouchers_produk_voucher_id_fkey FOREIGN KEY (produk_voucher_id) REFERENCES public.produk_vouchers(id) ON UPDATE CASCADE;


--
-- Name: data_vouchers data_vouchers_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_vouchers
    ADD CONSTRAINT data_vouchers_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: global_settings global_settings_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_settings
    ADD CONSTRAINT global_settings_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: kendaraans kendaraans_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kendaraans
    ADD CONSTRAINT kendaraans_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: kendaraans kendaraans_tipe_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kendaraans
    ADD CONSTRAINT kendaraans_tipe_kendaraan_id_fkey FOREIGN KEY (tipe_kendaraan_id) REFERENCES public.tipe_kendaraans(id) ON UPDATE CASCADE;


--
-- Name: kendaraans kendaraans_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kendaraans
    ADD CONSTRAINT kendaraans_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: laporan_riwayat_transaksi_members laporan_riwayat_transaksi_members_gerbang_masuk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_riwayat_transaksi_members
    ADD CONSTRAINT laporan_riwayat_transaksi_members_gerbang_masuk_id_fkey FOREIGN KEY (gerbang_masuk_id) REFERENCES public.pos(id) ON UPDATE CASCADE;


--
-- Name: laporan_riwayat_transaksi_members laporan_riwayat_transaksi_members_jenis_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_riwayat_transaksi_members
    ADD CONSTRAINT laporan_riwayat_transaksi_members_jenis_kendaraan_id_fkey FOREIGN KEY (jenis_kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE;


--
-- Name: laporan_riwayat_transaksi_members laporan_riwayat_transaksi_members_pintu_keluar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_riwayat_transaksi_members
    ADD CONSTRAINT laporan_riwayat_transaksi_members_pintu_keluar_id_fkey FOREIGN KEY (pintu_keluar_id) REFERENCES public.pos(id) ON UPDATE CASCADE;


--
-- Name: laporan_riwayat_transaksi_members laporan_riwayat_transaksi_members_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_riwayat_transaksi_members
    ADD CONSTRAINT laporan_riwayat_transaksi_members_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: laporan_transaksi_batals laporan_transaksi_batals_pintu_masuk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_transaksi_batals
    ADD CONSTRAINT laporan_transaksi_batals_pintu_masuk_id_fkey FOREIGN KEY (pintu_masuk_id) REFERENCES public.pos(id) ON UPDATE CASCADE;


--
-- Name: laporan_transaksi_batals laporan_transaksi_batals_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_transaksi_batals
    ADD CONSTRAINT laporan_transaksi_batals_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: laporan_transaksi_batals laporan_transaksi_batals_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_transaksi_batals
    ADD CONSTRAINT laporan_transaksi_batals_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: level_penggunas level_penggunas_perusahaan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_perusahaan_id_fkey FOREIGN KEY (perusahaan_id) REFERENCES public.perusahaans(id) ON UPDATE CASCADE;


--
-- Name: level_penggunas level_penggunas_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: nama_interfaces nama_interfaces_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nama_interfaces
    ADD CONSTRAINT nama_interfaces_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: nama_printers nama_printers_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nama_printers
    ADD CONSTRAINT nama_printers_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: parameters parameters_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parameters
    ADD CONSTRAINT parameters_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: payments payments_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: permasalahan_atau_perbaikans permasalahan_atau_perbaikans_pos_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permasalahan_atau_perbaikans
    ADD CONSTRAINT permasalahan_atau_perbaikans_pos_id_fkey FOREIGN KEY (pos_id) REFERENCES public.pos(id) ON UPDATE CASCADE;


--
-- Name: permasalahan_atau_perbaikans permasalahan_atau_perbaikans_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permasalahan_atau_perbaikans
    ADD CONSTRAINT permasalahan_atau_perbaikans_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: perusahaans perusahaans_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perusahaans
    ADD CONSTRAINT perusahaans_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: perusahaans perusahaans_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perusahaans
    ADD CONSTRAINT perusahaans_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: pos pos_nama_interface_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos
    ADD CONSTRAINT pos_nama_interface_id_fkey FOREIGN KEY (nama_interface_id) REFERENCES public.nama_interfaces(id) ON UPDATE CASCADE;


--
-- Name: pos pos_nama_printer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos
    ADD CONSTRAINT pos_nama_printer_id_fkey FOREIGN KEY (nama_printer_id) REFERENCES public.nama_printers(id) ON UPDATE CASCADE;


--
-- Name: pos pos_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos
    ADD CONSTRAINT pos_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: pos pos_tipe_manless_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos
    ADD CONSTRAINT pos_tipe_manless_id_fkey FOREIGN KEY (tipe_manless_id) REFERENCES public.tipe_manlesses(id) ON UPDATE CASCADE;


--
-- Name: pos pos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos
    ADD CONSTRAINT pos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: produk_members produk_members_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_members
    ADD CONSTRAINT produk_members_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: produk_members produk_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_members
    ADD CONSTRAINT produk_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: produk_vouchers produk_vouchers_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_vouchers
    ADD CONSTRAINT produk_vouchers_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: produk_vouchers produk_vouchers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_vouchers
    ADD CONSTRAINT produk_vouchers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: riwayat_ganti_nomor_polisi_v2 riwayat_ganti_nomor_polisi_v2_data_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_ganti_nomor_polisi_v2
    ADD CONSTRAINT riwayat_ganti_nomor_polisi_v2_data_member_id_fkey FOREIGN KEY (data_member_id) REFERENCES public.data_members(id) ON UPDATE CASCADE;


--
-- Name: riwayat_ganti_nomor_polisi_v2 riwayat_ganti_nomor_polisi_v2_kendaraan_baru_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_ganti_nomor_polisi_v2
    ADD CONSTRAINT riwayat_ganti_nomor_polisi_v2_kendaraan_baru_id_fkey FOREIGN KEY (kendaraan_baru_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: riwayat_ganti_nomor_polisi_v2 riwayat_ganti_nomor_polisi_v2_kendaraan_lama_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_ganti_nomor_polisi_v2
    ADD CONSTRAINT riwayat_ganti_nomor_polisi_v2_kendaraan_lama_id_fkey FOREIGN KEY (kendaraan_lama_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: riwayat_ganti_nomor_polisi_v2 riwayat_ganti_nomor_polisi_v2_produk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_ganti_nomor_polisi_v2
    ADD CONSTRAINT riwayat_ganti_nomor_polisi_v2_produk_id_fkey FOREIGN KEY (produk_id) REFERENCES public.produk_members(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: riwayat_transaksi_ganti_nopols riwayat_transaksi_ganti_nopols_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_ganti_nopols
    ADD CONSTRAINT riwayat_transaksi_ganti_nopols_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: riwayat_transaksi_ganti_nopols riwayat_transaksi_ganti_nopols_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_ganti_nopols
    ADD CONSTRAINT riwayat_transaksi_ganti_nopols_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: riwayat_transaksi_kartu_members riwayat_transaksi_kartu_members_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_kartu_members
    ADD CONSTRAINT riwayat_transaksi_kartu_members_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: riwayat_transaksi_kartu_members riwayat_transaksi_kartu_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_kartu_members
    ADD CONSTRAINT riwayat_transaksi_kartu_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: riwayat_transaksi_member riwayat_transaksi_member_data_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_member
    ADD CONSTRAINT riwayat_transaksi_member_data_member_id_fkey FOREIGN KEY (data_member_id) REFERENCES public.data_members(id) ON UPDATE CASCADE;


--
-- Name: riwayat_transaksi_member riwayat_transaksi_member_produk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_member
    ADD CONSTRAINT riwayat_transaksi_member_produk_id_fkey FOREIGN KEY (produk_id) REFERENCES public.produk_members(id) ON UPDATE CASCADE;


--
-- Name: shifts shifts_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shifts
    ADD CONSTRAINT shifts_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: shifts shifts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shifts
    ADD CONSTRAINT shifts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: tarif_dendas tarif_dendas_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_dendas
    ADD CONSTRAINT tarif_dendas_kendaraan_id_fkey FOREIGN KEY (kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tarif_dendas tarif_dendas_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_dendas
    ADD CONSTRAINT tarif_dendas_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: tarif_parkirs tarif_parkirs_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_parkirs
    ADD CONSTRAINT tarif_parkirs_kendaraan_id_fkey FOREIGN KEY (kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: tarif_parkirs tarif_parkirs_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_parkirs
    ADD CONSTRAINT tarif_parkirs_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: tipe_dendas tipe_dendas_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_dendas
    ADD CONSTRAINT tipe_dendas_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: tipe_kendaraans tipe_kendaraans_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_kendaraans
    ADD CONSTRAINT tipe_kendaraans_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: tipe_manlesses tipe_manlesses_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_manlesses
    ADD CONSTRAINT tipe_manlesses_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: transaksis transaksis_id_data_member_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_id_data_member_fkey FOREIGN KEY (id_data_member) REFERENCES public.data_members(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: transaksis transaksis_id_data_voucher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_id_data_voucher_fkey FOREIGN KEY (id_data_voucher) REFERENCES public.data_vouchers(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: transaksis transaksis_jenis_pembayaran_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_jenis_pembayaran_id_fkey FOREIGN KEY (jenis_pembayaran_id) REFERENCES public.payments(id) ON UPDATE CASCADE;


--
-- Name: transaksis transaksis_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_kendaraan_id_fkey FOREIGN KEY (kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE;


--
-- Name: transaksis transaksis_petugas_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_petugas_id_fkey FOREIGN KEY (petugas_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: transaksis transaksis_pintu_keluar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_pintu_keluar_id_fkey FOREIGN KEY (pintu_keluar_id) REFERENCES public.pos(id) ON UPDATE CASCADE;


--
-- Name: transaksis transaksis_pintu_masuk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_pintu_masuk_id_fkey FOREIGN KEY (pintu_masuk_id) REFERENCES public.pos(id) ON UPDATE CASCADE;


--
-- Name: transaksis transaksis_shift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_shift_id_fkey FOREIGN KEY (shift_id) REFERENCES public.shifts(id) ON UPDATE CASCADE;


--
-- Name: transaksis transaksis_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE;


--
-- Name: transaksis transaksis_tipe_denda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_tipe_denda_id_fkey FOREIGN KEY (tipe_denda_id) REFERENCES public.tipe_dendas(id) ON UPDATE CASCADE;


--
-- Name: users users_added_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_added_by_fkey FOREIGN KEY (added_by) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- Name: users users_level_pengguna_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_level_pengguna_id_fkey FOREIGN KEY (level_pengguna_id) REFERENCES public.level_penggunas(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: users users_perusahaan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_perusahaan_id_fkey FOREIGN KEY (perusahaan_id) REFERENCES public.perusahaans(id) ON UPDATE CASCADE;


--
-- Name: users users_tenant_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_tenant_id_fkey FOREIGN KEY (tenant_id) REFERENCES public.tenants(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- PostgreSQL database dump complete
--

