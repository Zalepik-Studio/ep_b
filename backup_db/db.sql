--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

-- Started on 2025-08-03 11:55:28

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
-- TOC entry 958 (class 1247 OID 1979548)
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
-- TOC entry 1024 (class 1247 OID 3083898)
-- Name: enum_aktivitas_gerbang_kendaraans_lokasi_gerbang; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_aktivitas_gerbang_kendaraans_lokasi_gerbang AS ENUM (
    'Masuk',
    'Keluar'
);


ALTER TYPE public.enum_aktivitas_gerbang_kendaraans_lokasi_gerbang OWNER TO postgres;

--
-- TOC entry 961 (class 1247 OID 1979554)
-- Name: enum_aktivitas_gerbang_kendaraans_status_palang; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_aktivitas_gerbang_kendaraans_status_palang AS ENUM (
    'Sukses',
    'Gagal',
    'Gagal (Sensor)'
);


ALTER TYPE public.enum_aktivitas_gerbang_kendaraans_status_palang OWNER TO postgres;

--
-- TOC entry 986 (class 1247 OID 3222101)
-- Name: enum_aktivitas_gerbang_kendaraans_tipe_gerbang; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_aktivitas_gerbang_kendaraans_tipe_gerbang AS ENUM (
    'In',
    'Out'
);


ALTER TYPE public.enum_aktivitas_gerbang_kendaraans_tipe_gerbang OWNER TO postgres;

--
-- TOC entry 1027 (class 1247 OID 2414568)
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
-- TOC entry 901 (class 1247 OID 1930836)
-- Name: enum_data_vouchers_model_bayar; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_data_vouchers_model_bayar AS ENUM (
    'Check In',
    'Check Out'
);


ALTER TYPE public.enum_data_vouchers_model_bayar OWNER TO postgres;

--
-- TOC entry 904 (class 1247 OID 1930842)
-- Name: enum_data_vouchers_verifikasi; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_data_vouchers_verifikasi AS ENUM (
    'Tiket',
    'Nopol'
);


ALTER TYPE public.enum_data_vouchers_verifikasi OWNER TO postgres;

--
-- TOC entry 907 (class 1247 OID 1930848)
-- Name: enum_kendaraans_tipe_kendaraan; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_kendaraans_tipe_kendaraan AS ENUM (
    'Mobil',
    'Motor',
    'All'
);


ALTER TYPE public.enum_kendaraans_tipe_kendaraan OWNER TO postgres;

--
-- TOC entry 910 (class 1247 OID 1930856)
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
-- TOC entry 913 (class 1247 OID 1930868)
-- Name: enum_permasalahan_atau_perbaikans_status; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_permasalahan_atau_perbaikans_status AS ENUM (
    'Pending',
    'On Progress',
    'Done'
);


ALTER TYPE public.enum_permasalahan_atau_perbaikans_status OWNER TO postgres;

--
-- TOC entry 916 (class 1247 OID 1930876)
-- Name: enum_permasalahan_atau_perbaikans_status_perbaikan; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_permasalahan_atau_perbaikans_status_perbaikan AS ENUM (
    'Pending',
    'On Progress',
    'Done'
);


ALTER TYPE public.enum_permasalahan_atau_perbaikans_status_perbaikan OWNER TO postgres;

--
-- TOC entry 919 (class 1247 OID 1930884)
-- Name: enum_permasalahan_atau_perbaikans_status_permasalahan; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_permasalahan_atau_perbaikans_status_permasalahan AS ENUM (
    'Pending',
    'On Progress',
    'Done'
);


ALTER TYPE public.enum_permasalahan_atau_perbaikans_status_permasalahan OWNER TO postgres;

--
-- TOC entry 955 (class 1247 OID 1938201)
-- Name: enum_perusahaans_jenis_perusahaan; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_perusahaans_jenis_perusahaan AS ENUM (
    'Pemilik Gedung',
    'Pemilik Kendaraan',
    'Tenant',
    'Developer'
);


ALTER TYPE public.enum_perusahaans_jenis_perusahaan OWNER TO postgres;

--
-- TOC entry 922 (class 1247 OID 1930892)
-- Name: enum_pos_nama_interface; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_pos_nama_interface AS ENUM (
    'BGI',
    'TWS',
    'PAWL',
    'SMART PARKING',
    'SER TELINKS',
    'USB TELINKS'
);


ALTER TYPE public.enum_pos_nama_interface OWNER TO postgres;

--
-- TOC entry 925 (class 1247 OID 1930906)
-- Name: enum_pos_nama_printer; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_pos_nama_printer AS ENUM (
    'Epson TM-T81 Receipt',
    'Epson TM-T82 Receipt',
    'Epson TM-U220 Receipt',
    ''
);


ALTER TYPE public.enum_pos_nama_printer OWNER TO postgres;

--
-- TOC entry 964 (class 1247 OID 2284079)
-- Name: enum_pos_nama_printer_id; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_pos_nama_printer_id AS ENUM (
    'Epson TM-T81 Receipt',
    'Epson TM-T82 Receipt',
    'Epson TM-U220 Receipt',
    'Epson TM-T88III Receipt',
    'Epson TM-T88IV Receipt',
    'Epson TM-T88V Receipt',
    'Epson TM-T82II Receipt'
);


ALTER TYPE public.enum_pos_nama_printer_id OWNER TO postgres;

--
-- TOC entry 928 (class 1247 OID 1930916)
-- Name: enum_pos_tipe_kendaraan; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_pos_tipe_kendaraan AS ENUM (
    'Mobil',
    'Motor',
    'All'
);


ALTER TYPE public.enum_pos_tipe_kendaraan OWNER TO postgres;

--
-- TOC entry 931 (class 1247 OID 1930924)
-- Name: enum_pos_tipe_manless; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_pos_tipe_manless AS ENUM (
    'Loop 1 with Button',
    'Loop 1 with Button and Feedback',
    'Feedback with Button',
    'Button Only'
);


ALTER TYPE public.enum_pos_tipe_manless OWNER TO postgres;

--
-- TOC entry 934 (class 1247 OID 1930934)
-- Name: enum_pos_tipe_pos; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_pos_tipe_pos AS ENUM (
    'In',
    'Out'
);


ALTER TYPE public.enum_pos_tipe_pos OWNER TO postgres;

--
-- TOC entry 937 (class 1247 OID 1930940)
-- Name: enum_produk_members_periode_unit; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_produk_members_periode_unit AS ENUM (
    'Hari',
    'Bulan',
    'Tahun'
);


ALTER TYPE public.enum_produk_members_periode_unit OWNER TO postgres;

--
-- TOC entry 940 (class 1247 OID 1930948)
-- Name: enum_produk_vouchers_metode_verifikasi; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_produk_vouchers_metode_verifikasi AS ENUM (
    'Tiket',
    'Nopol'
);


ALTER TYPE public.enum_produk_vouchers_metode_verifikasi OWNER TO postgres;

--
-- TOC entry 943 (class 1247 OID 1930954)
-- Name: enum_produk_vouchers_model_pembayaran; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_produk_vouchers_model_pembayaran AS ENUM (
    'Check In',
    'Check Out'
);


ALTER TYPE public.enum_produk_vouchers_model_pembayaran OWNER TO postgres;

--
-- TOC entry 946 (class 1247 OID 1930960)
-- Name: enum_produk_vouchers_periode_unit; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_produk_vouchers_periode_unit AS ENUM (
    'Keluar',
    'Hari',
    'Bulan'
);


ALTER TYPE public.enum_produk_vouchers_periode_unit OWNER TO postgres;

--
-- TOC entry 949 (class 1247 OID 1930968)
-- Name: enum_users_jenis_kelamin; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_jenis_kelamin AS ENUM (
    'Laki-laki',
    'Perempuan'
);


ALTER TYPE public.enum_users_jenis_kelamin OWNER TO postgres;

--
-- TOC entry 952 (class 1247 OID 1930974)
-- Name: enum_users_level; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_users_level AS ENUM (
    'Administrator',
    'Operator',
    'Reporting',
    'No Akses',
    'Kepala Lokasi',
    'Front Office'
);


ALTER TYPE public.enum_users_level OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 3343947)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.aktivitas_gerbang_kendaraans OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 3343946)
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
-- TOC entry 5507 (class 0 OID 0)
-- Dependencies: 217
-- Name: aktivitas_gerbang_kendaraans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.aktivitas_gerbang_kendaraans_id_seq OWNED BY public.aktivitas_gerbang_kendaraans.id;


--
-- TOC entry 266 (class 1259 OID 3344676)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.data_members OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 3344675)
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
-- TOC entry 5508 (class 0 OID 0)
-- Dependencies: 265
-- Name: data_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_members_id_seq OWNED BY public.data_members.id;


--
-- TOC entry 268 (class 1259 OID 3344720)
-- Name: data_nomor_polisis; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.data_nomor_polisis (
    id integer NOT NULL,
    data_member_id integer,
    kendaraan_id integer,
    nomor_polisi character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.data_nomor_polisis OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 3344719)
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
-- TOC entry 5509 (class 0 OID 0)
-- Dependencies: 267
-- Name: data_nomor_polisis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_nomor_polisis_id_seq OWNED BY public.data_nomor_polisis.id;


--
-- TOC entry 270 (class 1259 OID 3344981)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.data_vouchers OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 3344980)
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
-- TOC entry 5510 (class 0 OID 0)
-- Dependencies: 269
-- Name: data_vouchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.data_vouchers_id_seq OWNED BY public.data_vouchers.id;


--
-- TOC entry 220 (class 1259 OID 3343983)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.global_settings OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 3343982)
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
-- TOC entry 5511 (class 0 OID 0)
-- Dependencies: 219
-- Name: global_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.global_settings_id_seq OWNED BY public.global_settings.id;


--
-- TOC entry 222 (class 1259 OID 3343992)
-- Name: kendaraans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kendaraans (
    id integer NOT NULL,
    nama_kendaraan character varying(255),
    tipe_kendaraan_id integer,
    status boolean,
    user_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.kendaraans OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 3343991)
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
-- TOC entry 5512 (class 0 OID 0)
-- Dependencies: 221
-- Name: kendaraans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kendaraans_id_seq OWNED BY public.kendaraans.id;


--
-- TOC entry 224 (class 1259 OID 3343999)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.laporan_riwayat_transaksi_members OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 3343998)
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
-- TOC entry 5513 (class 0 OID 0)
-- Dependencies: 223
-- Name: laporan_riwayat_transaksi_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.laporan_riwayat_transaksi_members_id_seq OWNED BY public.laporan_riwayat_transaksi_members.id;


--
-- TOC entry 226 (class 1259 OID 3344008)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.laporan_transaksi_batals OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 3344007)
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
-- TOC entry 5514 (class 0 OID 0)
-- Dependencies: 225
-- Name: laporan_transaksi_batals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.laporan_transaksi_batals_id_seq OWNED BY public.laporan_transaksi_batals.id;


--
-- TOC entry 228 (class 1259 OID 3344017)
-- Name: level_penggunas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.level_penggunas (
    id integer NOT NULL,
    nama character varying(255),
    hak_akses jsonb,
    perusahaan_id integer,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.level_penggunas OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 3344016)
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
-- TOC entry 5515 (class 0 OID 0)
-- Dependencies: 227
-- Name: level_penggunas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.level_penggunas_id_seq OWNED BY public.level_penggunas.id;


--
-- TOC entry 230 (class 1259 OID 3344028)
-- Name: nama_interfaces; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nama_interfaces (
    id integer NOT NULL,
    nama_interface character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.nama_interfaces OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 3344027)
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
-- TOC entry 5516 (class 0 OID 0)
-- Dependencies: 229
-- Name: nama_interfaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nama_interfaces_id_seq OWNED BY public.nama_interfaces.id;


--
-- TOC entry 232 (class 1259 OID 3344035)
-- Name: nama_printers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nama_printers (
    id integer NOT NULL,
    nama_printer character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.nama_printers OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 3344034)
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
-- TOC entry 5517 (class 0 OID 0)
-- Dependencies: 231
-- Name: nama_printers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nama_printers_id_seq OWNED BY public.nama_printers.id;


--
-- TOC entry 234 (class 1259 OID 3344042)
-- Name: parameters; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.parameters (
    id integer NOT NULL,
    nama character varying(255),
    nilai character varying(255),
    keterangan character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.parameters OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 3344041)
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
-- TOC entry 5518 (class 0 OID 0)
-- Dependencies: 233
-- Name: parameters_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.parameters_id_seq OWNED BY public.parameters.id;


--
-- TOC entry 272 (class 1259 OID 3356182)
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    jenis_payment character varying(255),
    status boolean,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 3356181)
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
-- TOC entry 5519 (class 0 OID 0)
-- Dependencies: 271
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- TOC entry 236 (class 1259 OID 3344058)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.permasalahan_atau_perbaikans OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 3344057)
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
-- TOC entry 5520 (class 0 OID 0)
-- Dependencies: 235
-- Name: permasalahan_atau_perbaikans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.permasalahan_atau_perbaikans_id_seq OWNED BY public.permasalahan_atau_perbaikans.id;


--
-- TOC entry 238 (class 1259 OID 3344067)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.perusahaans OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 3344066)
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
-- TOC entry 5521 (class 0 OID 0)
-- Dependencies: 237
-- Name: perusahaans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.perusahaans_id_seq OWNED BY public.perusahaans.id;


--
-- TOC entry 240 (class 1259 OID 3344076)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.pos OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 3344075)
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
-- TOC entry 5522 (class 0 OID 0)
-- Dependencies: 239
-- Name: pos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pos_id_seq OWNED BY public.pos.id;


--
-- TOC entry 242 (class 1259 OID 3344085)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.produk_members OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 3344084)
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
-- TOC entry 5523 (class 0 OID 0)
-- Dependencies: 241
-- Name: produk_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produk_members_id_seq OWNED BY public.produk_members.id;


--
-- TOC entry 244 (class 1259 OID 3344094)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.produk_vouchers OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 3344093)
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
-- TOC entry 5524 (class 0 OID 0)
-- Dependencies: 243
-- Name: produk_vouchers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.produk_vouchers_id_seq OWNED BY public.produk_vouchers.id;


--
-- TOC entry 246 (class 1259 OID 3344103)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.riwayat_transaksi_ganti_nopols OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 3344102)
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
-- TOC entry 5525 (class 0 OID 0)
-- Dependencies: 245
-- Name: riwayat_transaksi_ganti_nopols_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.riwayat_transaksi_ganti_nopols_id_seq OWNED BY public.riwayat_transaksi_ganti_nopols.id;


--
-- TOC entry 248 (class 1259 OID 3344112)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.riwayat_transaksi_kartu_members OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 3344111)
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
-- TOC entry 5526 (class 0 OID 0)
-- Dependencies: 247
-- Name: riwayat_transaksi_kartu_members_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.riwayat_transaksi_kartu_members_id_seq OWNED BY public.riwayat_transaksi_kartu_members.id;


--
-- TOC entry 250 (class 1259 OID 3344121)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.shifts OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 3344120)
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
-- TOC entry 5527 (class 0 OID 0)
-- Dependencies: 249
-- Name: shifts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.shifts_id_seq OWNED BY public.shifts.id;


--
-- TOC entry 252 (class 1259 OID 3344128)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.tarif_dendas OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 3344127)
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
-- TOC entry 5528 (class 0 OID 0)
-- Dependencies: 251
-- Name: tarif_dendas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tarif_dendas_id_seq OWNED BY public.tarif_dendas.id;


--
-- TOC entry 254 (class 1259 OID 3344135)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.tarif_parkirs OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 3344134)
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
-- TOC entry 5529 (class 0 OID 0)
-- Dependencies: 253
-- Name: tarif_parkirs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tarif_parkirs_id_seq OWNED BY public.tarif_parkirs.id;


--
-- TOC entry 256 (class 1259 OID 3344142)
-- Name: tipe_dendas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipe_dendas (
    id integer NOT NULL,
    tipe_denda character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.tipe_dendas OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 3344141)
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
-- TOC entry 5530 (class 0 OID 0)
-- Dependencies: 255
-- Name: tipe_dendas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipe_dendas_id_seq OWNED BY public.tipe_dendas.id;


--
-- TOC entry 258 (class 1259 OID 3344149)
-- Name: tipe_kendaraans; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipe_kendaraans (
    id integer NOT NULL,
    tipe_kendaraan character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.tipe_kendaraans OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 3344148)
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
-- TOC entry 5531 (class 0 OID 0)
-- Dependencies: 257
-- Name: tipe_kendaraans_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipe_kendaraans_id_seq OWNED BY public.tipe_kendaraans.id;


--
-- TOC entry 260 (class 1259 OID 3344156)
-- Name: tipe_manlesses; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipe_manlesses (
    id integer NOT NULL,
    tipe_manless character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.tipe_manlesses OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 3344155)
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
-- TOC entry 5532 (class 0 OID 0)
-- Dependencies: 259
-- Name: tipe_manlesses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipe_manlesses_id_seq OWNED BY public.tipe_manlesses.id;


--
-- TOC entry 262 (class 1259 OID 3344163)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.transaksis OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 3344162)
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
-- TOC entry 5533 (class 0 OID 0)
-- Dependencies: 261
-- Name: transaksis_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transaksis_id_seq OWNED BY public.transaksis.id;


--
-- TOC entry 264 (class 1259 OID 3344172)
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
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 3344171)
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
-- TOC entry 5534 (class 0 OID 0)
-- Dependencies: 263
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4905 (class 2604 OID 3343950)
-- Name: aktivitas_gerbang_kendaraans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aktivitas_gerbang_kendaraans ALTER COLUMN id SET DEFAULT nextval('public.aktivitas_gerbang_kendaraans_id_seq'::regclass);


--
-- TOC entry 4929 (class 2604 OID 3344679)
-- Name: data_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_members ALTER COLUMN id SET DEFAULT nextval('public.data_members_id_seq'::regclass);


--
-- TOC entry 4930 (class 2604 OID 3344723)
-- Name: data_nomor_polisis id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis ALTER COLUMN id SET DEFAULT nextval('public.data_nomor_polisis_id_seq'::regclass);


--
-- TOC entry 4931 (class 2604 OID 3344984)
-- Name: data_vouchers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_vouchers ALTER COLUMN id SET DEFAULT nextval('public.data_vouchers_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 3343986)
-- Name: global_settings id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_settings ALTER COLUMN id SET DEFAULT nextval('public.global_settings_id_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 3343995)
-- Name: kendaraans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kendaraans ALTER COLUMN id SET DEFAULT nextval('public.kendaraans_id_seq'::regclass);


--
-- TOC entry 4908 (class 2604 OID 3344002)
-- Name: laporan_riwayat_transaksi_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_riwayat_transaksi_members ALTER COLUMN id SET DEFAULT nextval('public.laporan_riwayat_transaksi_members_id_seq'::regclass);


--
-- TOC entry 4909 (class 2604 OID 3344011)
-- Name: laporan_transaksi_batals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_transaksi_batals ALTER COLUMN id SET DEFAULT nextval('public.laporan_transaksi_batals_id_seq'::regclass);


--
-- TOC entry 4910 (class 2604 OID 3344020)
-- Name: level_penggunas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas ALTER COLUMN id SET DEFAULT nextval('public.level_penggunas_id_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 3344031)
-- Name: nama_interfaces id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nama_interfaces ALTER COLUMN id SET DEFAULT nextval('public.nama_interfaces_id_seq'::regclass);


--
-- TOC entry 4912 (class 2604 OID 3344038)
-- Name: nama_printers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nama_printers ALTER COLUMN id SET DEFAULT nextval('public.nama_printers_id_seq'::regclass);


--
-- TOC entry 4913 (class 2604 OID 3344045)
-- Name: parameters id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parameters ALTER COLUMN id SET DEFAULT nextval('public.parameters_id_seq'::regclass);


--
-- TOC entry 4932 (class 2604 OID 3356185)
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- TOC entry 4914 (class 2604 OID 3344061)
-- Name: permasalahan_atau_perbaikans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permasalahan_atau_perbaikans ALTER COLUMN id SET DEFAULT nextval('public.permasalahan_atau_perbaikans_id_seq'::regclass);


--
-- TOC entry 4915 (class 2604 OID 3344070)
-- Name: perusahaans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perusahaans ALTER COLUMN id SET DEFAULT nextval('public.perusahaans_id_seq'::regclass);


--
-- TOC entry 4916 (class 2604 OID 3344079)
-- Name: pos id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos ALTER COLUMN id SET DEFAULT nextval('public.pos_id_seq'::regclass);


--
-- TOC entry 4917 (class 2604 OID 3344088)
-- Name: produk_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_members ALTER COLUMN id SET DEFAULT nextval('public.produk_members_id_seq'::regclass);


--
-- TOC entry 4918 (class 2604 OID 3344097)
-- Name: produk_vouchers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_vouchers ALTER COLUMN id SET DEFAULT nextval('public.produk_vouchers_id_seq'::regclass);


--
-- TOC entry 4919 (class 2604 OID 3344106)
-- Name: riwayat_transaksi_ganti_nopols id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_ganti_nopols ALTER COLUMN id SET DEFAULT nextval('public.riwayat_transaksi_ganti_nopols_id_seq'::regclass);


--
-- TOC entry 4920 (class 2604 OID 3344115)
-- Name: riwayat_transaksi_kartu_members id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_kartu_members ALTER COLUMN id SET DEFAULT nextval('public.riwayat_transaksi_kartu_members_id_seq'::regclass);


--
-- TOC entry 4921 (class 2604 OID 3344124)
-- Name: shifts id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shifts ALTER COLUMN id SET DEFAULT nextval('public.shifts_id_seq'::regclass);


--
-- TOC entry 4922 (class 2604 OID 3344131)
-- Name: tarif_dendas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_dendas ALTER COLUMN id SET DEFAULT nextval('public.tarif_dendas_id_seq'::regclass);


--
-- TOC entry 4923 (class 2604 OID 3344138)
-- Name: tarif_parkirs id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_parkirs ALTER COLUMN id SET DEFAULT nextval('public.tarif_parkirs_id_seq'::regclass);


--
-- TOC entry 4924 (class 2604 OID 3344145)
-- Name: tipe_dendas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_dendas ALTER COLUMN id SET DEFAULT nextval('public.tipe_dendas_id_seq'::regclass);


--
-- TOC entry 4925 (class 2604 OID 3344152)
-- Name: tipe_kendaraans id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_kendaraans ALTER COLUMN id SET DEFAULT nextval('public.tipe_kendaraans_id_seq'::regclass);


--
-- TOC entry 4926 (class 2604 OID 3344159)
-- Name: tipe_manlesses id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_manlesses ALTER COLUMN id SET DEFAULT nextval('public.tipe_manlesses_id_seq'::regclass);


--
-- TOC entry 4927 (class 2604 OID 3344166)
-- Name: transaksis id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis ALTER COLUMN id SET DEFAULT nextval('public.transaksis_id_seq'::regclass);


--
-- TOC entry 4928 (class 2604 OID 3344175)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5447 (class 0 OID 3343947)
-- Dependencies: 218
-- Data for Name: aktivitas_gerbang_kendaraans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.aktivitas_gerbang_kendaraans (id, tiket, plat_nomor, kendaraan_id, waktu, lokasi_gerbang, buka_atau_tutup, petugas_id, status_palang, tipe_gerbang, data_member_id, "createdAt", "updatedAt") FROM stdin;
1	TIK100	R1020A	1	05:30:00	Masuk	Tertutup	1	Sukses	In	1	2025-08-03 10:04:40.877+07	2025-08-03 10:04:40.877+07
2	TIK200	R1020B	1	05:30:00	Masuk	Tertutup	1	Sukses	In	1	2025-08-03 10:04:53.216+07	2025-08-03 10:04:53.216+07
3	TIK300	R1020C	1	05:30:00	Masuk	Tertutup	1	Sukses	In	1	2025-08-03 10:04:59.877+07	2025-08-03 10:04:59.877+07
4	TIK400	R1020D	1	05:30:00	Masuk	Tertutup	1	Sukses	In	1	2025-08-03 10:05:03.801+07	2025-08-03 10:05:03.801+07
5	TIK500	R1020E	1	05:30:00	Masuk	Tertutup	1	Sukses	In	1	2025-08-03 10:05:18.533+07	2025-08-03 10:05:18.533+07
6	TIK500	R1020E	1	06:30:00	Keluar	Tertutup	1	Sukses	Out	1	2025-08-03 10:06:28.53+07	2025-08-03 10:06:28.53+07
\.


--
-- TOC entry 5495 (class 0 OID 3344676)
-- Dependencies: 266
-- Data for Name: data_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_members (id, nama, no_hp, perusahaan_id, akses_tiket, akses_kartu, no_kartu, tgl_input, produk_id, tarif, biaya_member, biaya_kartu, periode, user_id, "createdAt", "updatedAt") FROM stdin;
1	Itmamul Fahmi	082102342343	1	t	t	4435345345345	2000-05-31 07:00:00+07	1	50000	50000	50000	[2025-06-01,2025-06-03)	1	2025-08-03 09:55:17.952+07	2025-08-03 09:55:17.952+07
\.


--
-- TOC entry 5497 (class 0 OID 3344720)
-- Dependencies: 268
-- Data for Name: data_nomor_polisis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_nomor_polisis (id, data_member_id, kendaraan_id, nomor_polisi, "createdAt", "updatedAt") FROM stdin;
1	1	1	AB1234AC	2025-08-03 09:55:18.024+07	2025-08-03 09:55:18.024+07
2	1	1	AB1235AC	2025-08-03 09:55:18.024+07	2025-08-03 09:55:18.024+07
3	1	1	AB1236AC	2025-08-03 09:55:18.024+07	2025-08-03 09:55:18.024+07
\.


--
-- TOC entry 5499 (class 0 OID 3344981)
-- Dependencies: 270
-- Data for Name: data_vouchers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.data_vouchers (id, produk_voucher_id, periode, diskon, model_bayar, verifikasi, no_tiket, nomor_polisi, kendaraan_id, keterangan, "createdAt", "updatedAt") FROM stdin;
1	1	[2025-06-01,2025-06-03)	2000	Check In	Tiket	\N	\N	1	Data Voucher	2025-08-03 09:56:14.221+07	2025-08-03 09:56:14.221+07
\.


--
-- TOC entry 5449 (class 0 OID 3343983)
-- Dependencies: 220
-- Data for Name: global_settings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.global_settings (id, nama_operator, email_operator, no_telp_operator, no_fax_operator, alamat_operator, nama_lokasi, email_lokasi, no_telp_lokasi, no_fax_lokasi, alamat_lokasi, "createdAt", "updatedAt") FROM stdin;
1	Evosist Parking	evosistparking@gmail.com	08121324343	08342342423	Pekuncen, Banyumas	Pasar Megah Jaya	pasarmegahjaya@gmail.com	098768900232	08754345678	Pekuncen, Banyumas	2025-08-03 09:50:15.289+07	2025-08-03 09:50:15.289+07
\.


--
-- TOC entry 5451 (class 0 OID 3343992)
-- Dependencies: 222
-- Data for Name: kendaraans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kendaraans (id, nama_kendaraan, tipe_kendaraan_id, status, user_id, "createdAt", "updatedAt") FROM stdin;
1	Xenia	1	t	1	2025-08-03 09:51:11.935+07	2025-08-03 09:51:11.935+07
\.


--
-- TOC entry 5453 (class 0 OID 3343999)
-- Dependencies: 224
-- Data for Name: laporan_riwayat_transaksi_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.laporan_riwayat_transaksi_members (id, no, nomor_tiket, waktu_masuk, gerbang_masuk_id, jenis_kendaraan_id, nomor_polisi, waktu_keluar, pintu_keluar_id, durasi_parkir, denda, total_pembayaran, jenis_transaksi, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5455 (class 0 OID 3344008)
-- Dependencies: 226
-- Data for Name: laporan_transaksi_batals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.laporan_transaksi_batals (id, no_tiket, tanggal_masuk, pintu_masuk_id, tanggal_pembatalan, alasan_pembatalan, penjelasan_pembatalan, user_id, "createdAt", "updatedAt") FROM stdin;
1	AABBCC	2025-05-04 07:00:00+07	1	2025-08-03 10:30:05.609+07	Alasan Pembatalan	Penjelasan Pembatalan	1	2025-08-03 10:30:05.61+07	2025-08-03 10:30:05.61+07
\.


--
-- TOC entry 5457 (class 0 OID 3344017)
-- Dependencies: 228
-- Data for Name: level_penggunas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.level_penggunas (id, nama, hak_akses, perusahaan_id, "createdAt", "updatedAt") FROM stdin;
1	Super Admin	[{"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master Data", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Perusahaan"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "pengaturan": true}, "nama": "Level Pengguna"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Data Pengguna"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Pos (In/Out)"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Data Kendaraan"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Produk Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "perpanjang": true, "ganti_kartu": true, "riwayat_transaksi": true, "ganti_nomor_polisi": true}, "nama": "Data Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Produk Voucher"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Data Voucher"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "aktif_nonaktif": true}, "nama": "Shift"}]}, {"nama_menu": "Laporan Data", "nama_sub_menu": [{"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Kendaraan"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Pendapatan Parkir"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null, "batalkan_transaksi": true}, "nama": "Transaksi Batal"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Audit Transaksi"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null, "unggah_file": true}, "nama": "Settlement Cashless"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": {"read": null, "create": true, "delete": null, "update": null}, "nama": "Tambah Transaksi"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null}, "nama": "Riwayat Transaksi"}]}, {"nama_menu": "Pengaturan", "nama_sub_menu": [{"aksi": {"read": true, "create": null, "delete": null, "update": true}, "nama": "Tarif Parkir"}, {"aksi": {"read": true, "create": null, "delete": null, "update": true, "aktif_nonaktif": true}, "nama": "Tarif Denda"}, {"aksi": {"read": true, "create": null, "delete": null, "update": null, "aktif_nonaktif": true}, "nama": "Pembayaran"}, {"aksi": {"read": true, "create": null, "delete": null, "update": true}, "nama": "Parameter"}, {"aksi": {"read": true, "create": null, "delete": null, "update": true}, "nama": "Global"}]}, {"nama_menu": "Bantuan", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": true, "update": true, "proses_data_perbaikan": true}, "nama": "Tiket"}]}]	1	2025-08-03 09:49:54.251+07	2025-08-03 09:49:54.251+07
2	Super Administrator	[{"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama_menu": "Dashboard", "nama_sub_menu": null}, {"nama_menu": "Master", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "User"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "konfigurasi_menu": true}, "nama": "Level Akses"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Produk Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Produk Voucher"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true, "perpanjang": true, "ganti_kartu": true, "ganti_nopol": true}, "nama": "Data Member"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Data Voucher"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "POS"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Kendaraan"}, {"aksi": {"create": true, "delete": true, "update": true}, "nama": "Shift"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Perusahaan"}]}, {"nama_menu": "Setting", "nama_sub_menu": [{"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Tarif Parkir"}, {"aksi": {"read": true, "create": true, "delete": true, "update": true}, "nama": "Tarif Denda"}, {"aksi": {"read": true, "update": true}, "nama": "Parameter"}, {"aksi": {"read": true, "update": true}, "nama": "Global"}, {"aksi": {"read": true, "update": true}, "nama": "Payment"}]}, {"nama_menu": "Transaksi", "nama_sub_menu": [{"aksi": null, "nama": "Manual mix"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": {"read": true, "delete": true, "update": true, "create_perbaikan": true, "create_permasalahan": true}, "nama": "Permasalahan atau Perbaikan"}]}, {"nama_menu": "Report", "nama_sub_menu": [{"aksi": null, "nama": "Kendaraan"}, {"aksi": null, "nama": "Overnight"}, {"aksi": null, "nama": "Pendapatan Parkir"}, {"aksi": null, "nama": "Pendapatan Gabungan"}, {"aksi": null, "nama": "Pendapatan Member"}, {"aksi": null, "nama": "Pendapatan Voucher"}, {"aksi": null, "nama": "Pembatalan Transaksi"}, {"aksi": null, "nama": "Audit Transaksi"}, {"aksi": null, "nama": "Settlement Cashless"}]}]	\N	2025-08-03 11:49:30.717+07	2025-08-03 11:49:30.717+07
\.


--
-- TOC entry 5459 (class 0 OID 3344028)
-- Dependencies: 230
-- Data for Name: nama_interfaces; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nama_interfaces (id, nama_interface, "createdAt", "updatedAt") FROM stdin;
1	BGI	2025-08-03 09:53:06.617+07	2025-08-03 09:53:06.617+07
\.


--
-- TOC entry 5461 (class 0 OID 3344035)
-- Dependencies: 232
-- Data for Name: nama_printers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nama_printers (id, nama_printer, "createdAt", "updatedAt") FROM stdin;
1	EPSON TM-T82 Receipt	2025-08-03 09:53:01.773+07	2025-08-03 09:53:01.773+07
\.


--
-- TOC entry 5463 (class 0 OID 3344042)
-- Dependencies: 234
-- Data for Name: parameters; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.parameters (id, nama, nilai, keterangan, "createdAt", "updatedAt") FROM stdin;
1	Bayar Member Secara Berjenjang	false	Pembayaran member secara berjenjang ketika keluar	2025-08-03 09:52:39.771+07	2025-08-03 09:52:39.771+07
\.


--
-- TOC entry 5501 (class 0 OID 3356182)
-- Dependencies: 272
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (id, jenis_payment, status, "createdAt", "updatedAt") FROM stdin;
1	Tunai	f	2025-08-03 11:49:30.765+07	2025-08-03 11:49:30.766+07
2	Bank	f	2025-08-03 11:49:30.766+07	2025-08-03 11:49:30.766+07
3	QRIS	f	2025-08-03 11:49:30.766+07	2025-08-03 11:49:30.766+07
4	Member	f	2025-08-03 11:49:30.766+07	2025-08-03 11:49:30.766+07
\.


--
-- TOC entry 5465 (class 0 OID 3344058)
-- Dependencies: 236
-- Data for Name: permasalahan_atau_perbaikans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.permasalahan_atau_perbaikans (id, judul_permasalahan, tanggal_permasalahan, kategori_permasalahan, pos_id, hardware_atau_alat, penyebab_permasalahan, keterangan_permasalahan, nama_pelapor, status_permasalahan, tanggal_perbaikan, jenis_perbaikan, status_perbaikan, penanganan, keterangan_penanganan, nama_yang_menangani, "createdAt", "updatedAt") FROM stdin;
1	Error Barrier Gate	31-05-2021	Sistem	1	Hardware	Ada short dalam kelistrikan	Segera melakukan perbaikan	Fahmi	Pending	31-05-2004		Pending				2025-08-03 09:57:27.425+07	2025-08-03 09:57:27.425+07
\.


--
-- TOC entry 5467 (class 0 OID 3344067)
-- Dependencies: 238
-- Data for Name: perusahaans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perusahaans (id, nama, jenis_perusahaan, kontak, status, user_id, "createdAt", "updatedAt") FROM stdin;
1	Evolusi Sistem Digital	Pemilik Gedung	08235345345	t	\N	2025-08-03 09:49:43.508+07	2025-08-03 09:49:43.508+07
\.


--
-- TOC entry 5469 (class 0 OID 3344076)
-- Dependencies: 240
-- Data for Name: pos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pos (id, kode, keterangan, tipe_pos, tipe_manless_id, tipe_kendaraan, kamera_1, kamera_2, nama_printer_id, nama_interface_id, com_port, otorisasi, synchronize, user_id, "createdAt", "updatedAt") FROM stdin;
1	P1	Pos 1	In	1	All	t	t	1	1	1	t	1	1	2025-08-03 09:56:26.91+07	2025-08-03 09:56:26.91+07
\.


--
-- TOC entry 5471 (class 0 OID 3344085)
-- Dependencies: 242
-- Data for Name: produk_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produk_members (id, nama, periode, list_id_kendaraan, max_kendaraan, tarif, biaya_kartu, biaya_ganti_nopol, status, user_id, "createdAt", "updatedAt") FROM stdin;
1	Kartu Member 1	[2025-06-01,2025-06-10)	{1,1}	1	50000	50000	50000	t	1	2025-08-03 09:53:36.705+07	2025-08-03 09:53:36.705+07
\.


--
-- TOC entry 5473 (class 0 OID 3344094)
-- Dependencies: 244
-- Data for Name: produk_vouchers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.produk_vouchers (id, nama, periode, list_id_kendaraan, diskon, model_pembayaran, metode_verifikasi, status, user_id, "createdAt", "updatedAt") FROM stdin;
1	Tamu	[2025-05-31,2025-06-01)	{1,1}	2000	Check In	Tiket	t	1	2025-08-03 09:55:37.298+07	2025-08-03 09:55:37.298+07
\.


--
-- TOC entry 5475 (class 0 OID 3344103)
-- Dependencies: 246
-- Data for Name: riwayat_transaksi_ganti_nopols; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.riwayat_transaksi_ganti_nopols (id, tgl_transaksi, nomor_polisi_lama, nomor_polisi_baru, tarif, keterangan, user_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5477 (class 0 OID 3344112)
-- Dependencies: 248
-- Data for Name: riwayat_transaksi_kartu_members; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.riwayat_transaksi_kartu_members (id, tgl_transaksi, no_kartu, tarif, keterangan, user_id, "createdAt", "updatedAt") FROM stdin;
\.


--
-- TOC entry 5479 (class 0 OID 3344121)
-- Dependencies: 250
-- Data for Name: shifts; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.shifts (id, nama_shift, awal_shift, akhir_shift, status, user_id, "createdAt", "updatedAt") FROM stdin;
1	Shift 1	08:00:00	16:00:00	t	1	2025-08-03 09:56:54.695+07	2025-08-03 09:56:54.695+07
\.


--
-- TOC entry 5481 (class 0 OID 3344128)
-- Dependencies: 252
-- Data for Name: tarif_dendas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tarif_dendas (id, kendaraan_id, denda_tiket, denda_stnk, denda_member, status, "createdAt", "updatedAt") FROM stdin;
1	1	7000	7000	t	t	2025-08-03 09:53:19.38+07	2025-08-03 09:53:19.38+07
\.


--
-- TOC entry 5483 (class 0 OID 3344135)
-- Dependencies: 254
-- Data for Name: tarif_parkirs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tarif_parkirs (id, kendaraan_id, grace_period, tarif_grace_period, rotasi_pertama, tarif_rotasi_pertama, rotasi_kedua, tarif_rotasi_kedua, rotasi_ketiga, tarif_rotasi_ketiga, tarif_maksimal, "createdAt", "updatedAt") FROM stdin;
1	1	10	1000	2	5000	3	9000	3	8000	0	2025-08-03 09:52:29.182+07	2025-08-03 09:52:29.182+07
\.


--
-- TOC entry 5485 (class 0 OID 3344142)
-- Dependencies: 256
-- Data for Name: tipe_dendas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipe_dendas (id, tipe_denda, "createdAt", "updatedAt") FROM stdin;
1	Tidak Dapat Menunjukkan STNK	2025-08-03 09:52:49.263+07	2025-08-03 09:52:49.263+07
\.


--
-- TOC entry 5487 (class 0 OID 3344149)
-- Dependencies: 258
-- Data for Name: tipe_kendaraans; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipe_kendaraans (id, tipe_kendaraan, "createdAt", "updatedAt") FROM stdin;
1	Mobil	2025-08-03 09:50:36.106+07	2025-08-03 09:50:36.106+07
\.


--
-- TOC entry 5489 (class 0 OID 3344156)
-- Dependencies: 260
-- Data for Name: tipe_manlesses; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipe_manlesses (id, tipe_manless, "createdAt", "updatedAt") FROM stdin;
1	Loop 1 with Button and Feedback	2025-08-03 09:52:54.071+07	2025-08-03 09:52:54.071+07
\.


--
-- TOC entry 5491 (class 0 OID 3344163)
-- Dependencies: 262
-- Data for Name: transaksis; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transaksis (id, tanggal_masuk, pintu_masuk_id, no_tiket, is_manual, kendaraan_id, nomor_polisi, pintu_keluar_id, tanggal_keluar, petugas_id, shift_id, denda, tipe_denda_id, is_active, jenis_pembayaran_id, biaya_parkir, id_data_voucher, jumlah_denda_stnk, jumlah_denda_tiket, "interval", keterangan_atau_penjelasan, id_data_member, "createdAt", "updatedAt") FROM stdin;
2	2025-05-04 07:00:00+07	1	TIK500	f	1	R1020A	1	2025-05-04 17:00:00+07	1	1	f	1	t	1	78000	\N	0	0	10	keterangan	\N	2025-08-03 10:09:17.033+07	2025-08-03 10:09:17.033+07
3	2025-05-04 07:00:00+07	1	TIK500	f	1	R1020A	1	2025-05-04 17:00:00+07	1	1	t	1	t	1	78000	1	7000	7000	10	keterangan	1	2025-08-03 10:12:37.745+07	2025-08-03 10:12:37.745+07
1	2025-05-04 07:00:00+07	1	AABBCC	f	1	R2020AJ	1	2025-05-04 17:00:00+07	1	1	f	1	f	1	78000	\N	0	0	10	keterangan	\N	2025-08-03 09:57:16.897+07	2025-08-03 10:30:05.604+07
4	2025-05-04 07:00:00+07	1	TIK600	t	1	R1020B	1	2025-05-04 17:00:00+07	1	1	t	1	t	1	78000	1	7000	7000	10	keterangan	1	2025-08-03 10:31:08.92+07	2025-08-03 10:31:08.92+07
\.


--
-- TOC entry 5493 (class 0 OID 3344172)
-- Dependencies: 264
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, nama, jenis_kelamin, no_hp, alamat_lengkap, username, password, perusahaan_id, level_pengguna_id, status, added_by, "createdAt", "updatedAt") FROM stdin;
1	Evosist	Laki-laki	0823234234234	Jakarta	admin	$argon2id$v=19$m=65536,t=3,p=4$DHfmy7xmI6DvKrRCmV+utA$DXIqk6AvB1BnPpewWkxqWUNi+W0tqXr3OOz6tL1vG5A	1	1	t	\N	2025-08-03 09:50:03.706+07	2025-08-03 09:50:03.706+07
\.


--
-- TOC entry 5535 (class 0 OID 0)
-- Dependencies: 217
-- Name: aktivitas_gerbang_kendaraans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.aktivitas_gerbang_kendaraans_id_seq', 6, true);


--
-- TOC entry 5536 (class 0 OID 0)
-- Dependencies: 265
-- Name: data_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.data_members_id_seq', 1, true);


--
-- TOC entry 5537 (class 0 OID 0)
-- Dependencies: 267
-- Name: data_nomor_polisis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.data_nomor_polisis_id_seq', 3, true);


--
-- TOC entry 5538 (class 0 OID 0)
-- Dependencies: 269
-- Name: data_vouchers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.data_vouchers_id_seq', 1, true);


--
-- TOC entry 5539 (class 0 OID 0)
-- Dependencies: 219
-- Name: global_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.global_settings_id_seq', 1, true);


--
-- TOC entry 5540 (class 0 OID 0)
-- Dependencies: 221
-- Name: kendaraans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kendaraans_id_seq', 1, true);


--
-- TOC entry 5541 (class 0 OID 0)
-- Dependencies: 223
-- Name: laporan_riwayat_transaksi_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.laporan_riwayat_transaksi_members_id_seq', 1, false);


--
-- TOC entry 5542 (class 0 OID 0)
-- Dependencies: 225
-- Name: laporan_transaksi_batals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.laporan_transaksi_batals_id_seq', 1, true);


--
-- TOC entry 5543 (class 0 OID 0)
-- Dependencies: 227
-- Name: level_penggunas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.level_penggunas_id_seq', 1, true);


--
-- TOC entry 5544 (class 0 OID 0)
-- Dependencies: 229
-- Name: nama_interfaces_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nama_interfaces_id_seq', 1, true);


--
-- TOC entry 5545 (class 0 OID 0)
-- Dependencies: 231
-- Name: nama_printers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nama_printers_id_seq', 1, true);


--
-- TOC entry 5546 (class 0 OID 0)
-- Dependencies: 233
-- Name: parameters_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.parameters_id_seq', 1, true);


--
-- TOC entry 5547 (class 0 OID 0)
-- Dependencies: 271
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_id_seq', 4, true);


--
-- TOC entry 5548 (class 0 OID 0)
-- Dependencies: 235
-- Name: permasalahan_atau_perbaikans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.permasalahan_atau_perbaikans_id_seq', 1, true);


--
-- TOC entry 5549 (class 0 OID 0)
-- Dependencies: 237
-- Name: perusahaans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.perusahaans_id_seq', 1, true);


--
-- TOC entry 5550 (class 0 OID 0)
-- Dependencies: 239
-- Name: pos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pos_id_seq', 1, true);


--
-- TOC entry 5551 (class 0 OID 0)
-- Dependencies: 241
-- Name: produk_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produk_members_id_seq', 1, true);


--
-- TOC entry 5552 (class 0 OID 0)
-- Dependencies: 243
-- Name: produk_vouchers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.produk_vouchers_id_seq', 1, true);


--
-- TOC entry 5553 (class 0 OID 0)
-- Dependencies: 245
-- Name: riwayat_transaksi_ganti_nopols_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.riwayat_transaksi_ganti_nopols_id_seq', 1, false);


--
-- TOC entry 5554 (class 0 OID 0)
-- Dependencies: 247
-- Name: riwayat_transaksi_kartu_members_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.riwayat_transaksi_kartu_members_id_seq', 1, false);


--
-- TOC entry 5555 (class 0 OID 0)
-- Dependencies: 249
-- Name: shifts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.shifts_id_seq', 1, true);


--
-- TOC entry 5556 (class 0 OID 0)
-- Dependencies: 251
-- Name: tarif_dendas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tarif_dendas_id_seq', 1, true);


--
-- TOC entry 5557 (class 0 OID 0)
-- Dependencies: 253
-- Name: tarif_parkirs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tarif_parkirs_id_seq', 1, true);


--
-- TOC entry 5558 (class 0 OID 0)
-- Dependencies: 255
-- Name: tipe_dendas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipe_dendas_id_seq', 1, true);


--
-- TOC entry 5559 (class 0 OID 0)
-- Dependencies: 257
-- Name: tipe_kendaraans_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipe_kendaraans_id_seq', 1, true);


--
-- TOC entry 5560 (class 0 OID 0)
-- Dependencies: 259
-- Name: tipe_manlesses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipe_manlesses_id_seq', 1, true);


--
-- TOC entry 5561 (class 0 OID 0)
-- Dependencies: 261
-- Name: transaksis_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transaksis_id_seq', 4, true);


--
-- TOC entry 5562 (class 0 OID 0)
-- Dependencies: 263
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- TOC entry 4934 (class 2606 OID 3343954)
-- Name: aktivitas_gerbang_kendaraans aktivitas_gerbang_kendaraans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aktivitas_gerbang_kendaraans
    ADD CONSTRAINT aktivitas_gerbang_kendaraans_pkey PRIMARY KEY (id);


--
-- TOC entry 5184 (class 2606 OID 3344683)
-- Name: data_members data_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_members
    ADD CONSTRAINT data_members_pkey PRIMARY KEY (id);


--
-- TOC entry 5186 (class 2606 OID 3356261)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key UNIQUE (nomor_polisi);


--
-- TOC entry 5188 (class 2606 OID 3356259)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key1 UNIQUE (nomor_polisi);


--
-- TOC entry 5190 (class 2606 OID 3356249)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key10 UNIQUE (nomor_polisi);


--
-- TOC entry 5192 (class 2606 OID 3356271)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key11 UNIQUE (nomor_polisi);


--
-- TOC entry 5194 (class 2606 OID 3356273)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key12 UNIQUE (nomor_polisi);


--
-- TOC entry 5196 (class 2606 OID 3356275)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key13 UNIQUE (nomor_polisi);


--
-- TOC entry 5198 (class 2606 OID 3356247)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key14 UNIQUE (nomor_polisi);


--
-- TOC entry 5200 (class 2606 OID 3356277)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key15 UNIQUE (nomor_polisi);


--
-- TOC entry 5202 (class 2606 OID 3356279)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key16 UNIQUE (nomor_polisi);


--
-- TOC entry 5204 (class 2606 OID 3356245)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key17 UNIQUE (nomor_polisi);


--
-- TOC entry 5206 (class 2606 OID 3356281)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key18 UNIQUE (nomor_polisi);


--
-- TOC entry 5208 (class 2606 OID 3356283)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key19 UNIQUE (nomor_polisi);


--
-- TOC entry 5210 (class 2606 OID 3356257)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key2 UNIQUE (nomor_polisi);


--
-- TOC entry 5212 (class 2606 OID 3356243)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key20 UNIQUE (nomor_polisi);


--
-- TOC entry 5214 (class 2606 OID 3356285)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key21 UNIQUE (nomor_polisi);


--
-- TOC entry 5216 (class 2606 OID 3356241)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key22 UNIQUE (nomor_polisi);


--
-- TOC entry 5218 (class 2606 OID 3356287)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key23 UNIQUE (nomor_polisi);


--
-- TOC entry 5220 (class 2606 OID 3356239)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key24 UNIQUE (nomor_polisi);


--
-- TOC entry 5222 (class 2606 OID 3356289)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key25 UNIQUE (nomor_polisi);


--
-- TOC entry 5224 (class 2606 OID 3356237)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key26 UNIQUE (nomor_polisi);


--
-- TOC entry 5226 (class 2606 OID 3356291)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key27 UNIQUE (nomor_polisi);


--
-- TOC entry 5228 (class 2606 OID 3356235)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key28 UNIQUE (nomor_polisi);


--
-- TOC entry 5230 (class 2606 OID 3356293)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key29 UNIQUE (nomor_polisi);


--
-- TOC entry 5232 (class 2606 OID 3356263)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key3 UNIQUE (nomor_polisi);


--
-- TOC entry 5234 (class 2606 OID 3356233)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key30 UNIQUE (nomor_polisi);


--
-- TOC entry 5236 (class 2606 OID 3356295)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key31 UNIQUE (nomor_polisi);


--
-- TOC entry 5238 (class 2606 OID 3356231)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key32 UNIQUE (nomor_polisi);


--
-- TOC entry 5240 (class 2606 OID 3356297)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key33 UNIQUE (nomor_polisi);


--
-- TOC entry 5242 (class 2606 OID 3356255)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key4 UNIQUE (nomor_polisi);


--
-- TOC entry 5244 (class 2606 OID 3356265)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key5 UNIQUE (nomor_polisi);


--
-- TOC entry 5246 (class 2606 OID 3356253)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key6 UNIQUE (nomor_polisi);


--
-- TOC entry 5248 (class 2606 OID 3356267)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key7 UNIQUE (nomor_polisi);


--
-- TOC entry 5250 (class 2606 OID 3356251)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key8 UNIQUE (nomor_polisi);


--
-- TOC entry 5252 (class 2606 OID 3356269)
-- Name: data_nomor_polisis data_nomor_polisis_nomor_polisi_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_nomor_polisi_key9 UNIQUE (nomor_polisi);


--
-- TOC entry 5254 (class 2606 OID 3344725)
-- Name: data_nomor_polisis data_nomor_polisis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_pkey PRIMARY KEY (id);


--
-- TOC entry 5256 (class 2606 OID 3344988)
-- Name: data_vouchers data_vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_vouchers
    ADD CONSTRAINT data_vouchers_pkey PRIMARY KEY (id);


--
-- TOC entry 4936 (class 2606 OID 3343990)
-- Name: global_settings global_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.global_settings
    ADD CONSTRAINT global_settings_pkey PRIMARY KEY (id);


--
-- TOC entry 4938 (class 2606 OID 3343997)
-- Name: kendaraans kendaraans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kendaraans
    ADD CONSTRAINT kendaraans_pkey PRIMARY KEY (id);


--
-- TOC entry 4940 (class 2606 OID 3344006)
-- Name: laporan_riwayat_transaksi_members laporan_riwayat_transaksi_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_riwayat_transaksi_members
    ADD CONSTRAINT laporan_riwayat_transaksi_members_pkey PRIMARY KEY (id);


--
-- TOC entry 4942 (class 2606 OID 3344015)
-- Name: laporan_transaksi_batals laporan_transaksi_batals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_transaksi_batals
    ADD CONSTRAINT laporan_transaksi_batals_pkey PRIMARY KEY (id);


--
-- TOC entry 4944 (class 2606 OID 3356398)
-- Name: level_penggunas level_penggunas_nama_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key UNIQUE (nama);


--
-- TOC entry 4946 (class 2606 OID 3356396)
-- Name: level_penggunas level_penggunas_nama_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key1 UNIQUE (nama);


--
-- TOC entry 4948 (class 2606 OID 3356386)
-- Name: level_penggunas level_penggunas_nama_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key10 UNIQUE (nama);


--
-- TOC entry 4950 (class 2606 OID 3356384)
-- Name: level_penggunas level_penggunas_nama_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key11 UNIQUE (nama);


--
-- TOC entry 4952 (class 2606 OID 3356410)
-- Name: level_penggunas level_penggunas_nama_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key12 UNIQUE (nama);


--
-- TOC entry 4954 (class 2606 OID 3356348)
-- Name: level_penggunas level_penggunas_nama_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key13 UNIQUE (nama);


--
-- TOC entry 4956 (class 2606 OID 3356350)
-- Name: level_penggunas level_penggunas_nama_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key14 UNIQUE (nama);


--
-- TOC entry 4958 (class 2606 OID 3356382)
-- Name: level_penggunas level_penggunas_nama_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key15 UNIQUE (nama);


--
-- TOC entry 4960 (class 2606 OID 3356352)
-- Name: level_penggunas level_penggunas_nama_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key16 UNIQUE (nama);


--
-- TOC entry 4962 (class 2606 OID 3356354)
-- Name: level_penggunas level_penggunas_nama_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key17 UNIQUE (nama);


--
-- TOC entry 4964 (class 2606 OID 3356380)
-- Name: level_penggunas level_penggunas_nama_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key18 UNIQUE (nama);


--
-- TOC entry 4966 (class 2606 OID 3356356)
-- Name: level_penggunas level_penggunas_nama_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key19 UNIQUE (nama);


--
-- TOC entry 4968 (class 2606 OID 3356400)
-- Name: level_penggunas level_penggunas_nama_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key2 UNIQUE (nama);


--
-- TOC entry 4970 (class 2606 OID 3356378)
-- Name: level_penggunas level_penggunas_nama_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key20 UNIQUE (nama);


--
-- TOC entry 4972 (class 2606 OID 3356376)
-- Name: level_penggunas level_penggunas_nama_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key21 UNIQUE (nama);


--
-- TOC entry 4974 (class 2606 OID 3356358)
-- Name: level_penggunas level_penggunas_nama_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key22 UNIQUE (nama);


--
-- TOC entry 4976 (class 2606 OID 3356374)
-- Name: level_penggunas level_penggunas_nama_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key23 UNIQUE (nama);


--
-- TOC entry 4978 (class 2606 OID 3356372)
-- Name: level_penggunas level_penggunas_nama_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key24 UNIQUE (nama);


--
-- TOC entry 4980 (class 2606 OID 3356390)
-- Name: level_penggunas level_penggunas_nama_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key25 UNIQUE (nama);


--
-- TOC entry 4982 (class 2606 OID 3356360)
-- Name: level_penggunas level_penggunas_nama_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key26 UNIQUE (nama);


--
-- TOC entry 4984 (class 2606 OID 3356370)
-- Name: level_penggunas level_penggunas_nama_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key27 UNIQUE (nama);


--
-- TOC entry 4986 (class 2606 OID 3356362)
-- Name: level_penggunas level_penggunas_nama_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key28 UNIQUE (nama);


--
-- TOC entry 4988 (class 2606 OID 3356368)
-- Name: level_penggunas level_penggunas_nama_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key29 UNIQUE (nama);


--
-- TOC entry 4990 (class 2606 OID 3356402)
-- Name: level_penggunas level_penggunas_nama_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key3 UNIQUE (nama);


--
-- TOC entry 4992 (class 2606 OID 3356364)
-- Name: level_penggunas level_penggunas_nama_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key30 UNIQUE (nama);


--
-- TOC entry 4994 (class 2606 OID 3356366)
-- Name: level_penggunas level_penggunas_nama_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key31 UNIQUE (nama);


--
-- TOC entry 4996 (class 2606 OID 3356412)
-- Name: level_penggunas level_penggunas_nama_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key32 UNIQUE (nama);


--
-- TOC entry 4998 (class 2606 OID 3356346)
-- Name: level_penggunas level_penggunas_nama_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key33 UNIQUE (nama);


--
-- TOC entry 5000 (class 2606 OID 3356414)
-- Name: level_penggunas level_penggunas_nama_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key34 UNIQUE (nama);


--
-- TOC entry 5002 (class 2606 OID 3356394)
-- Name: level_penggunas level_penggunas_nama_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key4 UNIQUE (nama);


--
-- TOC entry 5004 (class 2606 OID 3356404)
-- Name: level_penggunas level_penggunas_nama_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key5 UNIQUE (nama);


--
-- TOC entry 5006 (class 2606 OID 3356392)
-- Name: level_penggunas level_penggunas_nama_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key6 UNIQUE (nama);


--
-- TOC entry 5008 (class 2606 OID 3356406)
-- Name: level_penggunas level_penggunas_nama_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key7 UNIQUE (nama);


--
-- TOC entry 5010 (class 2606 OID 3356388)
-- Name: level_penggunas level_penggunas_nama_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key8 UNIQUE (nama);


--
-- TOC entry 5012 (class 2606 OID 3356408)
-- Name: level_penggunas level_penggunas_nama_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_nama_key9 UNIQUE (nama);


--
-- TOC entry 5014 (class 2606 OID 3344024)
-- Name: level_penggunas level_penggunas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_pkey PRIMARY KEY (id);


--
-- TOC entry 5016 (class 2606 OID 3344033)
-- Name: nama_interfaces nama_interfaces_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nama_interfaces
    ADD CONSTRAINT nama_interfaces_pkey PRIMARY KEY (id);


--
-- TOC entry 5018 (class 2606 OID 3344040)
-- Name: nama_printers nama_printers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nama_printers
    ADD CONSTRAINT nama_printers_pkey PRIMARY KEY (id);


--
-- TOC entry 5020 (class 2606 OID 3344049)
-- Name: parameters parameters_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.parameters
    ADD CONSTRAINT parameters_pkey PRIMARY KEY (id);


--
-- TOC entry 5258 (class 2606 OID 3356187)
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- TOC entry 5022 (class 2606 OID 3344065)
-- Name: permasalahan_atau_perbaikans permasalahan_atau_perbaikans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permasalahan_atau_perbaikans
    ADD CONSTRAINT permasalahan_atau_perbaikans_pkey PRIMARY KEY (id);


--
-- TOC entry 5024 (class 2606 OID 3344074)
-- Name: perusahaans perusahaans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perusahaans
    ADD CONSTRAINT perusahaans_pkey PRIMARY KEY (id);


--
-- TOC entry 5026 (class 2606 OID 3344083)
-- Name: pos pos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos
    ADD CONSTRAINT pos_pkey PRIMARY KEY (id);


--
-- TOC entry 5028 (class 2606 OID 3344092)
-- Name: produk_members produk_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_members
    ADD CONSTRAINT produk_members_pkey PRIMARY KEY (id);


--
-- TOC entry 5030 (class 2606 OID 3344101)
-- Name: produk_vouchers produk_vouchers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_vouchers
    ADD CONSTRAINT produk_vouchers_pkey PRIMARY KEY (id);


--
-- TOC entry 5032 (class 2606 OID 3344110)
-- Name: riwayat_transaksi_ganti_nopols riwayat_transaksi_ganti_nopols_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_ganti_nopols
    ADD CONSTRAINT riwayat_transaksi_ganti_nopols_pkey PRIMARY KEY (id);


--
-- TOC entry 5034 (class 2606 OID 3344119)
-- Name: riwayat_transaksi_kartu_members riwayat_transaksi_kartu_members_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_kartu_members
    ADD CONSTRAINT riwayat_transaksi_kartu_members_pkey PRIMARY KEY (id);


--
-- TOC entry 5036 (class 2606 OID 3344126)
-- Name: shifts shifts_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shifts
    ADD CONSTRAINT shifts_pkey PRIMARY KEY (id);


--
-- TOC entry 5038 (class 2606 OID 3344133)
-- Name: tarif_dendas tarif_dendas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_dendas
    ADD CONSTRAINT tarif_dendas_pkey PRIMARY KEY (id);


--
-- TOC entry 5040 (class 2606 OID 3344140)
-- Name: tarif_parkirs tarif_parkirs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_parkirs
    ADD CONSTRAINT tarif_parkirs_pkey PRIMARY KEY (id);


--
-- TOC entry 5042 (class 2606 OID 3344147)
-- Name: tipe_dendas tipe_dendas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_dendas
    ADD CONSTRAINT tipe_dendas_pkey PRIMARY KEY (id);


--
-- TOC entry 5044 (class 2606 OID 3344154)
-- Name: tipe_kendaraans tipe_kendaraans_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_kendaraans
    ADD CONSTRAINT tipe_kendaraans_pkey PRIMARY KEY (id);


--
-- TOC entry 5046 (class 2606 OID 3344161)
-- Name: tipe_manlesses tipe_manlesses_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipe_manlesses
    ADD CONSTRAINT tipe_manlesses_pkey PRIMARY KEY (id);


--
-- TOC entry 5048 (class 2606 OID 3344170)
-- Name: transaksis transaksis_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_pkey PRIMARY KEY (id);


--
-- TOC entry 5050 (class 2606 OID 3356060)
-- Name: users users_nama_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key UNIQUE (nama);


--
-- TOC entry 5052 (class 2606 OID 3356062)
-- Name: users users_nama_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key1 UNIQUE (nama);


--
-- TOC entry 5054 (class 2606 OID 3356074)
-- Name: users users_nama_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key10 UNIQUE (nama);


--
-- TOC entry 5056 (class 2606 OID 3356052)
-- Name: users users_nama_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key11 UNIQUE (nama);


--
-- TOC entry 5058 (class 2606 OID 3356050)
-- Name: users users_nama_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key12 UNIQUE (nama);


--
-- TOC entry 5060 (class 2606 OID 3356076)
-- Name: users users_nama_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key13 UNIQUE (nama);


--
-- TOC entry 5062 (class 2606 OID 3356048)
-- Name: users users_nama_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key14 UNIQUE (nama);


--
-- TOC entry 5064 (class 2606 OID 3356078)
-- Name: users users_nama_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key15 UNIQUE (nama);


--
-- TOC entry 5066 (class 2606 OID 3356080)
-- Name: users users_nama_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key16 UNIQUE (nama);


--
-- TOC entry 5068 (class 2606 OID 3356046)
-- Name: users users_nama_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key17 UNIQUE (nama);


--
-- TOC entry 5070 (class 2606 OID 3356082)
-- Name: users users_nama_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key18 UNIQUE (nama);


--
-- TOC entry 5072 (class 2606 OID 3356044)
-- Name: users users_nama_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key19 UNIQUE (nama);


--
-- TOC entry 5074 (class 2606 OID 3356058)
-- Name: users users_nama_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key2 UNIQUE (nama);


--
-- TOC entry 5076 (class 2606 OID 3356042)
-- Name: users users_nama_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key20 UNIQUE (nama);


--
-- TOC entry 5078 (class 2606 OID 3356084)
-- Name: users users_nama_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key21 UNIQUE (nama);


--
-- TOC entry 5080 (class 2606 OID 3356040)
-- Name: users users_nama_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key22 UNIQUE (nama);


--
-- TOC entry 5082 (class 2606 OID 3356086)
-- Name: users users_nama_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key23 UNIQUE (nama);


--
-- TOC entry 5084 (class 2606 OID 3356038)
-- Name: users users_nama_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key24 UNIQUE (nama);


--
-- TOC entry 5086 (class 2606 OID 3356088)
-- Name: users users_nama_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key25 UNIQUE (nama);


--
-- TOC entry 5088 (class 2606 OID 3356036)
-- Name: users users_nama_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key26 UNIQUE (nama);


--
-- TOC entry 5090 (class 2606 OID 3356090)
-- Name: users users_nama_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key27 UNIQUE (nama);


--
-- TOC entry 5092 (class 2606 OID 3356034)
-- Name: users users_nama_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key28 UNIQUE (nama);


--
-- TOC entry 5094 (class 2606 OID 3356092)
-- Name: users users_nama_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key29 UNIQUE (nama);


--
-- TOC entry 5096 (class 2606 OID 3356064)
-- Name: users users_nama_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key3 UNIQUE (nama);


--
-- TOC entry 5098 (class 2606 OID 3356094)
-- Name: users users_nama_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key30 UNIQUE (nama);


--
-- TOC entry 5100 (class 2606 OID 3356096)
-- Name: users users_nama_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key31 UNIQUE (nama);


--
-- TOC entry 5102 (class 2606 OID 3356032)
-- Name: users users_nama_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key32 UNIQUE (nama);


--
-- TOC entry 5104 (class 2606 OID 3356066)
-- Name: users users_nama_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key4 UNIQUE (nama);


--
-- TOC entry 5106 (class 2606 OID 3356068)
-- Name: users users_nama_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key5 UNIQUE (nama);


--
-- TOC entry 5108 (class 2606 OID 3356056)
-- Name: users users_nama_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key6 UNIQUE (nama);


--
-- TOC entry 5110 (class 2606 OID 3356054)
-- Name: users users_nama_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key7 UNIQUE (nama);


--
-- TOC entry 5112 (class 2606 OID 3356070)
-- Name: users users_nama_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key8 UNIQUE (nama);


--
-- TOC entry 5114 (class 2606 OID 3356072)
-- Name: users users_nama_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_nama_key9 UNIQUE (nama);


--
-- TOC entry 5116 (class 2606 OID 3344179)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5118 (class 2606 OID 3356104)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 5120 (class 2606 OID 3356106)
-- Name: users users_username_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key1 UNIQUE (username);


--
-- TOC entry 5122 (class 2606 OID 3356118)
-- Name: users users_username_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key10 UNIQUE (username);


--
-- TOC entry 5124 (class 2606 OID 3356156)
-- Name: users users_username_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key11 UNIQUE (username);


--
-- TOC entry 5126 (class 2606 OID 3356154)
-- Name: users users_username_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key12 UNIQUE (username);


--
-- TOC entry 5128 (class 2606 OID 3356144)
-- Name: users users_username_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key13 UNIQUE (username);


--
-- TOC entry 5130 (class 2606 OID 3356152)
-- Name: users users_username_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key14 UNIQUE (username);


--
-- TOC entry 5132 (class 2606 OID 3356146)
-- Name: users users_username_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key15 UNIQUE (username);


--
-- TOC entry 5134 (class 2606 OID 3356148)
-- Name: users users_username_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key16 UNIQUE (username);


--
-- TOC entry 5136 (class 2606 OID 3356150)
-- Name: users users_username_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key17 UNIQUE (username);


--
-- TOC entry 5138 (class 2606 OID 3356120)
-- Name: users users_username_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key18 UNIQUE (username);


--
-- TOC entry 5140 (class 2606 OID 3356142)
-- Name: users users_username_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key19 UNIQUE (username);


--
-- TOC entry 5142 (class 2606 OID 3356102)
-- Name: users users_username_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key2 UNIQUE (username);


--
-- TOC entry 5144 (class 2606 OID 3356140)
-- Name: users users_username_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key20 UNIQUE (username);


--
-- TOC entry 5146 (class 2606 OID 3356122)
-- Name: users users_username_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key21 UNIQUE (username);


--
-- TOC entry 5148 (class 2606 OID 3356138)
-- Name: users users_username_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key22 UNIQUE (username);


--
-- TOC entry 5150 (class 2606 OID 3356124)
-- Name: users users_username_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key23 UNIQUE (username);


--
-- TOC entry 5152 (class 2606 OID 3356126)
-- Name: users users_username_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key24 UNIQUE (username);


--
-- TOC entry 5154 (class 2606 OID 3356128)
-- Name: users users_username_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key25 UNIQUE (username);


--
-- TOC entry 5156 (class 2606 OID 3356136)
-- Name: users users_username_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key26 UNIQUE (username);


--
-- TOC entry 5158 (class 2606 OID 3356130)
-- Name: users users_username_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key27 UNIQUE (username);


--
-- TOC entry 5160 (class 2606 OID 3356134)
-- Name: users users_username_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key28 UNIQUE (username);


--
-- TOC entry 5162 (class 2606 OID 3356132)
-- Name: users users_username_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key29 UNIQUE (username);


--
-- TOC entry 5164 (class 2606 OID 3356108)
-- Name: users users_username_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key3 UNIQUE (username);


--
-- TOC entry 5166 (class 2606 OID 3356162)
-- Name: users users_username_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key30 UNIQUE (username);


--
-- TOC entry 5168 (class 2606 OID 3356164)
-- Name: users users_username_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key31 UNIQUE (username);


--
-- TOC entry 5170 (class 2606 OID 3356100)
-- Name: users users_username_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key32 UNIQUE (username);


--
-- TOC entry 5172 (class 2606 OID 3356110)
-- Name: users users_username_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key4 UNIQUE (username);


--
-- TOC entry 5174 (class 2606 OID 3356112)
-- Name: users users_username_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key5 UNIQUE (username);


--
-- TOC entry 5176 (class 2606 OID 3356160)
-- Name: users users_username_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key6 UNIQUE (username);


--
-- TOC entry 5178 (class 2606 OID 3356158)
-- Name: users users_username_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key7 UNIQUE (username);


--
-- TOC entry 5180 (class 2606 OID 3356114)
-- Name: users users_username_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key8 UNIQUE (username);


--
-- TOC entry 5182 (class 2606 OID 3356116)
-- Name: users users_username_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key9 UNIQUE (username);


--
-- TOC entry 5259 (class 2606 OID 3356198)
-- Name: aktivitas_gerbang_kendaraans aktivitas_gerbang_kendaraans_data_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aktivitas_gerbang_kendaraans
    ADD CONSTRAINT aktivitas_gerbang_kendaraans_data_member_id_fkey FOREIGN KEY (data_member_id) REFERENCES public.data_members(id) ON UPDATE CASCADE;


--
-- TOC entry 5260 (class 2606 OID 3356188)
-- Name: aktivitas_gerbang_kendaraans aktivitas_gerbang_kendaraans_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aktivitas_gerbang_kendaraans
    ADD CONSTRAINT aktivitas_gerbang_kendaraans_kendaraan_id_fkey FOREIGN KEY (kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE;


--
-- TOC entry 5261 (class 2606 OID 3356193)
-- Name: aktivitas_gerbang_kendaraans aktivitas_gerbang_kendaraans_petugas_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.aktivitas_gerbang_kendaraans
    ADD CONSTRAINT aktivitas_gerbang_kendaraans_petugas_id_fkey FOREIGN KEY (petugas_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5294 (class 2606 OID 3356203)
-- Name: data_members data_members_perusahaan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_members
    ADD CONSTRAINT data_members_perusahaan_id_fkey FOREIGN KEY (perusahaan_id) REFERENCES public.perusahaans(id) ON UPDATE CASCADE;


--
-- TOC entry 5295 (class 2606 OID 3356208)
-- Name: data_members data_members_produk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_members
    ADD CONSTRAINT data_members_produk_id_fkey FOREIGN KEY (produk_id) REFERENCES public.produk_members(id) ON UPDATE CASCADE;


--
-- TOC entry 5296 (class 2606 OID 3356213)
-- Name: data_members data_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_members
    ADD CONSTRAINT data_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5297 (class 2606 OID 3356218)
-- Name: data_nomor_polisis data_nomor_polisis_data_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_data_member_id_fkey FOREIGN KEY (data_member_id) REFERENCES public.data_members(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5298 (class 2606 OID 3356223)
-- Name: data_nomor_polisis data_nomor_polisis_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_nomor_polisis
    ADD CONSTRAINT data_nomor_polisis_kendaraan_id_fkey FOREIGN KEY (kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE;


--
-- TOC entry 5299 (class 2606 OID 3356303)
-- Name: data_vouchers data_vouchers_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_vouchers
    ADD CONSTRAINT data_vouchers_kendaraan_id_fkey FOREIGN KEY (kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE;


--
-- TOC entry 5300 (class 2606 OID 3356298)
-- Name: data_vouchers data_vouchers_produk_voucher_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.data_vouchers
    ADD CONSTRAINT data_vouchers_produk_voucher_id_fkey FOREIGN KEY (produk_voucher_id) REFERENCES public.produk_vouchers(id) ON UPDATE CASCADE;


--
-- TOC entry 5262 (class 2606 OID 3356308)
-- Name: kendaraans kendaraans_tipe_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kendaraans
    ADD CONSTRAINT kendaraans_tipe_kendaraan_id_fkey FOREIGN KEY (tipe_kendaraan_id) REFERENCES public.tipe_kendaraans(id) ON UPDATE CASCADE;


--
-- TOC entry 5263 (class 2606 OID 3356313)
-- Name: kendaraans kendaraans_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kendaraans
    ADD CONSTRAINT kendaraans_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5264 (class 2606 OID 3356318)
-- Name: laporan_riwayat_transaksi_members laporan_riwayat_transaksi_members_gerbang_masuk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_riwayat_transaksi_members
    ADD CONSTRAINT laporan_riwayat_transaksi_members_gerbang_masuk_id_fkey FOREIGN KEY (gerbang_masuk_id) REFERENCES public.pos(id) ON UPDATE CASCADE;


--
-- TOC entry 5265 (class 2606 OID 3356323)
-- Name: laporan_riwayat_transaksi_members laporan_riwayat_transaksi_members_jenis_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_riwayat_transaksi_members
    ADD CONSTRAINT laporan_riwayat_transaksi_members_jenis_kendaraan_id_fkey FOREIGN KEY (jenis_kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE;


--
-- TOC entry 5266 (class 2606 OID 3356328)
-- Name: laporan_riwayat_transaksi_members laporan_riwayat_transaksi_members_pintu_keluar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_riwayat_transaksi_members
    ADD CONSTRAINT laporan_riwayat_transaksi_members_pintu_keluar_id_fkey FOREIGN KEY (pintu_keluar_id) REFERENCES public.pos(id) ON UPDATE CASCADE;


--
-- TOC entry 5267 (class 2606 OID 3356333)
-- Name: laporan_transaksi_batals laporan_transaksi_batals_pintu_masuk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_transaksi_batals
    ADD CONSTRAINT laporan_transaksi_batals_pintu_masuk_id_fkey FOREIGN KEY (pintu_masuk_id) REFERENCES public.pos(id) ON UPDATE CASCADE;


--
-- TOC entry 5268 (class 2606 OID 3356338)
-- Name: laporan_transaksi_batals laporan_transaksi_batals_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.laporan_transaksi_batals
    ADD CONSTRAINT laporan_transaksi_batals_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5269 (class 2606 OID 3356415)
-- Name: level_penggunas level_penggunas_perusahaan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.level_penggunas
    ADD CONSTRAINT level_penggunas_perusahaan_id_fkey FOREIGN KEY (perusahaan_id) REFERENCES public.perusahaans(id) ON UPDATE CASCADE;


--
-- TOC entry 5270 (class 2606 OID 3356420)
-- Name: permasalahan_atau_perbaikans permasalahan_atau_perbaikans_pos_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.permasalahan_atau_perbaikans
    ADD CONSTRAINT permasalahan_atau_perbaikans_pos_id_fkey FOREIGN KEY (pos_id) REFERENCES public.pos(id) ON UPDATE CASCADE;


--
-- TOC entry 5271 (class 2606 OID 3356425)
-- Name: perusahaans perusahaans_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.perusahaans
    ADD CONSTRAINT perusahaans_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5272 (class 2606 OID 3356440)
-- Name: pos pos_nama_interface_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos
    ADD CONSTRAINT pos_nama_interface_id_fkey FOREIGN KEY (nama_interface_id) REFERENCES public.nama_interfaces(id) ON UPDATE CASCADE;


--
-- TOC entry 5273 (class 2606 OID 3356435)
-- Name: pos pos_nama_printer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos
    ADD CONSTRAINT pos_nama_printer_id_fkey FOREIGN KEY (nama_printer_id) REFERENCES public.nama_printers(id) ON UPDATE CASCADE;


--
-- TOC entry 5274 (class 2606 OID 3356430)
-- Name: pos pos_tipe_manless_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos
    ADD CONSTRAINT pos_tipe_manless_id_fkey FOREIGN KEY (tipe_manless_id) REFERENCES public.tipe_manlesses(id) ON UPDATE CASCADE;


--
-- TOC entry 5275 (class 2606 OID 3356445)
-- Name: pos pos_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pos
    ADD CONSTRAINT pos_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5276 (class 2606 OID 3356450)
-- Name: produk_members produk_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_members
    ADD CONSTRAINT produk_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5277 (class 2606 OID 3356455)
-- Name: produk_vouchers produk_vouchers_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produk_vouchers
    ADD CONSTRAINT produk_vouchers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5278 (class 2606 OID 3356460)
-- Name: riwayat_transaksi_ganti_nopols riwayat_transaksi_ganti_nopols_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_ganti_nopols
    ADD CONSTRAINT riwayat_transaksi_ganti_nopols_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5279 (class 2606 OID 3356465)
-- Name: riwayat_transaksi_kartu_members riwayat_transaksi_kartu_members_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.riwayat_transaksi_kartu_members
    ADD CONSTRAINT riwayat_transaksi_kartu_members_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5280 (class 2606 OID 3356470)
-- Name: shifts shifts_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.shifts
    ADD CONSTRAINT shifts_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5281 (class 2606 OID 3356475)
-- Name: tarif_dendas tarif_dendas_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_dendas
    ADD CONSTRAINT tarif_dendas_kendaraan_id_fkey FOREIGN KEY (kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5282 (class 2606 OID 3356480)
-- Name: tarif_parkirs tarif_parkirs_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_parkirs
    ADD CONSTRAINT tarif_parkirs_kendaraan_id_fkey FOREIGN KEY (kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5283 (class 2606 OID 3356024)
-- Name: transaksis transaksis_id_data_member_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_id_data_member_fkey FOREIGN KEY (id_data_member) REFERENCES public.data_members(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 5284 (class 2606 OID 3356019)
-- Name: transaksis transaksis_id_data_voucher_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_id_data_voucher_fkey FOREIGN KEY (id_data_voucher) REFERENCES public.data_vouchers(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 5285 (class 2606 OID 3356490)
-- Name: transaksis transaksis_kendaraan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_kendaraan_id_fkey FOREIGN KEY (kendaraan_id) REFERENCES public.kendaraans(id) ON UPDATE CASCADE;


--
-- TOC entry 5286 (class 2606 OID 3356500)
-- Name: transaksis transaksis_petugas_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_petugas_id_fkey FOREIGN KEY (petugas_id) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5287 (class 2606 OID 3356495)
-- Name: transaksis transaksis_pintu_keluar_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_pintu_keluar_id_fkey FOREIGN KEY (pintu_keluar_id) REFERENCES public.pos(id) ON UPDATE CASCADE;


--
-- TOC entry 5288 (class 2606 OID 3356485)
-- Name: transaksis transaksis_pintu_masuk_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_pintu_masuk_id_fkey FOREIGN KEY (pintu_masuk_id) REFERENCES public.pos(id) ON UPDATE CASCADE;


--
-- TOC entry 5289 (class 2606 OID 3356505)
-- Name: transaksis transaksis_shift_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_shift_id_fkey FOREIGN KEY (shift_id) REFERENCES public.shifts(id) ON UPDATE CASCADE;


--
-- TOC entry 5290 (class 2606 OID 3356510)
-- Name: transaksis transaksis_tipe_denda_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transaksis
    ADD CONSTRAINT transaksis_tipe_denda_id_fkey FOREIGN KEY (tipe_denda_id) REFERENCES public.tipe_dendas(id) ON UPDATE CASCADE;


--
-- TOC entry 5291 (class 2606 OID 3356175)
-- Name: users users_added_by_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_added_by_fkey FOREIGN KEY (added_by) REFERENCES public.users(id) ON UPDATE CASCADE;


--
-- TOC entry 5292 (class 2606 OID 3356170)
-- Name: users users_level_pengguna_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_level_pengguna_id_fkey FOREIGN KEY (level_pengguna_id) REFERENCES public.level_penggunas(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 5293 (class 2606 OID 3356165)
-- Name: users users_perusahaan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_perusahaan_id_fkey FOREIGN KEY (perusahaan_id) REFERENCES public.perusahaans(id) ON UPDATE CASCADE;


-- Completed on 2025-08-03 11:55:28

--
-- PostgreSQL database dump complete
--

