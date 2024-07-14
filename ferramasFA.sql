-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 15-07-2024 a las 00:47:44
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `ferramas`
--
CREATE DATABASE IF NOT EXISTS `Ferramas` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci;
USE `Ferramas`;
-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `auth_group`
--

INSERT INTO `auth_group` (`id`, `name`) VALUES
(2, 'administrador'),
(5, 'bodeguero'),
(1, 'cliente'),
(4, 'contador'),
(3, 'vendedor');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_carrito`
--

CREATE TABLE `core_carrito` (
  `id` bigint(20) NOT NULL,
  `cantidad_prod` int(11) NOT NULL,
  `id_usuario_id` bigint(20) NOT NULL,
  `producto_carrito_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `core_carrito`
--

INSERT INTO `core_carrito` (`id`, `cantidad_prod`, `id_usuario_id`, `producto_carrito_id`) VALUES
(52, 1, 1, 25);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_carroproducto`
--

CREATE TABLE `core_carroproducto` (
  `id` bigint(20) NOT NULL,
  `producto` bigint(20) NOT NULL,
  `cantidad` bigint(20) NOT NULL,
  `usuario` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_donacion`
--

CREATE TABLE `core_donacion` (
  `id` bigint(20) NOT NULL,
  `monto_a_donar` int(11) NOT NULL,
  `id_usuario_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_estadoorden`
--

CREATE TABLE `core_estadoorden` (
  `id` bigint(20) NOT NULL,
  `estado_orden` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `core_estadoorden`
--

INSERT INTO `core_estadoorden` (`id`, `estado_orden`) VALUES
(1, 'validación'),
(2, 'preparación'),
(3, 'reparto'),
(4, 'entregado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_marca`
--

CREATE TABLE `core_marca` (
  `id` bigint(20) NOT NULL,
  `nombre_marca` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `core_marca`
--

INSERT INTO `core_marca` (`id`, `nombre_marca`) VALUES
(1, 'ferramas'),
(2, 'bosch'),
(3, 'Makitah');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_mensaje`
--

CREATE TABLE `core_mensaje` (
  `id` bigint(20) NOT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(150) NOT NULL,
  `creado_en` date NOT NULL,
  `modificado_en` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_orden`
--

CREATE TABLE `core_orden` (
  `id` bigint(20) NOT NULL,
  `precio_orden` int(11) DEFAULT NULL,
  `creado_en` date NOT NULL,
  `modificado_en` date DEFAULT NULL,
  `descuento_sub` int(11) NOT NULL,
  `estado_orden_id` bigint(20) NOT NULL,
  `id_usuario_id` bigint(20) NOT NULL,
  `direccion_envio` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `core_orden`
--

INSERT INTO `core_orden` (`id`, `precio_orden`, `creado_en`, `modificado_en`, `descuento_sub`, `estado_orden_id`, `id_usuario_id`, `direccion_envio`) VALUES
(5, 223, '2024-07-13', '2024-07-13', 0, 4, 1, 'Hyrule 234'),
(6, 234, '2024-07-13', '2024-07-13', 0, 1, 1, 'Hyrule 234'),
(7, 201, '2024-07-14', '2024-07-14', 0, 4, 1, 'Hyrule 234');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_ordenproducto`
--

CREATE TABLE `core_ordenproducto` (
  `id` bigint(20) NOT NULL,
  `cantidad_prod` int(11) NOT NULL,
  `orden_id` bigint(20) NOT NULL,
  `producto_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `core_ordenproducto`
--

INSERT INTO `core_ordenproducto` (`id`, `cantidad_prod`, `orden_id`, `producto_id`) VALUES
(7, 1, 5, 24),
(9, 1, 6, 29),
(11, 2, 7, 24);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_producto`
--

CREATE TABLE `core_producto` (
  `id` bigint(20) NOT NULL,
  `imagen` varchar(100) DEFAULT NULL,
  `nombre` varchar(50) NOT NULL,
  `descripcion` varchar(500) NOT NULL,
  `precio` int(11) NOT NULL,
  `stock` int(11) NOT NULL,
  `creado_en` date NOT NULL,
  `modificado_en` date NOT NULL,
  `marca_id` bigint(20) NOT NULL,
  `tipo_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `core_producto`
--

INSERT INTO `core_producto` (`id`, `imagen`, `nombre`, `descripcion`, `precio`, `stock`, `creado_en`, `modificado_en`, `marca_id`, `tipo_id`) VALUES
(24, 'productos/3559b_VtyUNJY.png', 'hola luxhito', 'Este es un producto de prueba para demostración', 100, 47, '2024-07-12', '2024-07-14', 1, 1),
(25, 'productos/Maxresdefault.jpg', 'Producto de prueba 2 ahora', 'Este es un producto de prueba para demostración', 100, 49, '2024-07-12', '2024-07-14', 1, 1),
(27, 'productos/unknown-1_LLCXotv.png', 'Caja de clavos', 'sdsdsdsddsdsd', 122, 13, '2024-07-13', '2024-07-13', 1, 4),
(28, 'productos/unknown-1_VjRsic7.png', 'Caja de clavos', 'sdsdsdsdwewew', 12, 12, '2024-07-13', '2024-07-13', 1, 2),
(29, 'productos/3559b.png', 'Ferfgfg', 'ffffffffffffffffffff', 234, 22, '2024-07-13', '2024-07-13', 1, 2),
(31, 'productos/Imagen_de_WhatsApp_2024-04-15_a_las_20.48.33_8b5e2e7e.jpg', 'Caja de clavos', 'ESTA ES UNA CAJA DE CLAVOS', 123, 23, '2024-07-14', '2024-07-14', 3, 3);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_suscripcion`
--

CREATE TABLE `core_suscripcion` (
  `id` bigint(20) NOT NULL,
  `suscrito_el` date NOT NULL,
  `renovacion_el` date DEFAULT NULL,
  `id_usuario_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_tipoproducto`
--

CREATE TABLE `core_tipoproducto` (
  `id` bigint(20) NOT NULL,
  `nombreTipoProducto` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `core_tipoproducto`
--

INSERT INTO `core_tipoproducto` (`id`, `nombreTipoProducto`) VALUES
(1, 'Herramientas Electricas'),
(2, 'Soldaduras'),
(3, 'Herramientas Generales'),
(4, 'Suplementos de Jardin');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_usuario`
--

CREATE TABLE `core_usuario` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `direccion` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `core_usuario`
--

INSERT INTO `core_usuario` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `direccion`) VALUES
(1, 'pbkdf2_sha256$600000$nZ4t5kRpffZfikB5VWd252$izPHj/jtQuTAoMlccpxN1sZVG3CXDjwkWzQCgRYjSsY=', '2024-07-14 22:26:53.357125', 1, 'admin', 'admin', 'admin', 'fre.cardenas@duocuc.cl', 1, 1, '2023-06-24 05:45:36.000000', 'Hyrule 234'),
(35, 'pbkdf2_sha256$600000$GeYUah5XTUox4qB6u6IczJ$lsmQ1dD6muMSxbZfvn+r1r+VlRLrKYRXvpq/+WQztZg=', '2024-07-14 21:14:41.864822', 0, 'freddy1', 'freddy', 'cardenas', 'freddyacr02@gmail.com', 0, 1, '2024-07-14 21:13:39.000000', 'el reten'),
(39, 'pbkdf2_sha256$600000$8CLFHks9PPum7KXO0p731z$+NgBkJozpLbn+k4FSvO6atnPYIvLYUd9PnlRqwb+DJQ=', '2024-07-14 21:34:18.520731', 0, 'luis', 'luis', 'gonzalez', 'luisgonzalez@gmail.com', 0, 1, '2024-07-14 21:24:55.000000', 'LAS PALMAS 23'),
(40, 'pbkdf2_sha256$600000$hgZPdE7gdKcLbdArezj5f0$qD3vexEo4Uk1s1RUvkafjwhLnyrVAyBzmvIjbmi4Ptk=', '2024-07-14 21:33:23.221916', 0, 'Manuel', 'Manuel', 'Miqueles', 'manuel.miqueles@gmail.com', 0, 1, '2024-07-14 21:25:37.000000', 'el reten'),
(41, 'pbkdf2_sha256$600000$jkG1jGaltw0gcwket6VunU$x+oZcYlAuzsHg+8Wp/uV+lP4U1z8ds202A8FMxQ02tM=', '2024-07-14 21:28:36.801749', 0, 'felipe', 'felipe', 'Torres', 'felipe.torres@gmail.com', 0, 1, '2024-07-14 21:28:28.603832', 'LAS PALMAS 23');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_usuario_groups`
--

CREATE TABLE `core_usuario_groups` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `core_usuario_groups`
--

INSERT INTO `core_usuario_groups` (`id`, `usuario_id`, `group_id`) VALUES
(5, 1, 1),
(1, 1, 2),
(4, 1, 3),
(11, 35, 1),
(12, 35, 3),
(17, 39, 1),
(19, 39, 5),
(18, 40, 1),
(20, 40, 4),
(21, 41, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `core_usuario_user_permissions`
--

CREATE TABLE `core_usuario_user_permissions` (
  `id` bigint(20) NOT NULL,
  `usuario_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2023-06-24 07:14:39.157929', '1', 'Cliente', 1, '[{\"added\": {}}]', 3, 1),
(2, '2023-06-24 07:14:53.123396', '2', 'administrador', 1, '[{\"added\": {}}]', 3, 1),
(3, '2023-06-24 07:17:59.705638', '1', 'Cliente', 2, '[{\"changed\": {\"fields\": [\"Permissions\"]}}]', 3, 1),
(4, '2023-06-24 07:29:31.298282', '1', 'admin', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 6, 1),
(5, '2023-06-24 07:29:36.322103', '1', 'cliente', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 3, 1),
(6, '2023-06-24 07:39:24.424900', '2', 'ArmorStand', 3, '', 6, 1),
(7, '2023-06-24 08:27:16.380787', '3', 'vendor', 1, '[{\"added\": {}}]', 3, 1),
(8, '2023-06-24 08:27:43.611644', '3', 'vendedor', 2, '[{\"changed\": {\"fields\": [\"Name\"]}}]', 3, 1),
(9, '2023-06-24 08:27:52.587252', '1', 'admin', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 6, 1),
(10, '2023-06-24 08:28:20.401072', '1', 'admin', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 6, 1),
(11, '2023-06-24 08:28:26.530008', '5', 'VendeDoor', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 6, 1),
(12, '2023-06-24 08:28:43.509833', '3', 'ArmorStand', 3, '', 6, 1),
(13, '2023-06-25 08:24:30.694575', '6', 'Pepe', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 6, 1),
(14, '2024-07-14 21:14:28.081091', '35', 'freddy', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 6, 1),
(15, '2024-07-14 21:17:04.437341', '8', 'freddy', 3, '', 6, 1),
(16, '2024-07-14 21:17:15.980091', '5', 'Jordan', 3, '', 6, 1),
(17, '2024-07-14 21:17:20.501032', '34', 'vendedor', 3, '', 6, 1),
(18, '2024-07-14 21:17:25.606212', '7', 'freddy', 3, '', 6, 1),
(19, '2024-07-14 21:17:30.630071', '4', 'Alfredo', 3, '', 6, 1),
(20, '2024-07-14 21:18:08.854235', '36', 'luis', 1, '[{\"added\": {}}]', 6, 1),
(21, '2024-07-14 21:22:04.625165', '37', 'felipe', 1, '[{\"added\": {}}]', 6, 1),
(22, '2024-07-14 21:22:58.009062', '38', 'Manuel', 1, '[{\"added\": {}}]', 6, 1),
(23, '2024-07-14 21:23:46.932055', '36', 'luis', 2, '[]', 6, 1),
(24, '2024-07-14 21:24:27.693551', '36', 'luis', 3, '', 6, 1),
(25, '2024-07-14 21:24:31.890959', '37', 'felipe', 3, '', 6, 1),
(26, '2024-07-14 21:24:35.201513', '38', 'Manuel', 3, '', 6, 1),
(27, '2024-07-14 21:26:39.244804', '39', 'luis', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 6, 1),
(28, '2024-07-14 21:26:43.613137', '40', 'Manuel', 2, '[{\"changed\": {\"fields\": [\"Groups\"]}}]', 6, 1);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(14, 'core', 'carrito'),
(16, 'core', 'donacion'),
(7, 'core', 'estadoorden'),
(8, 'core', 'marca'),
(9, 'core', 'mensaje'),
(10, 'core', 'orden'),
(15, 'core', 'ordenproducto'),
(13, 'core', 'producto'),
(12, 'core', 'suscripcion'),
(11, 'core', 'tipoproducto'),
(6, 'core', 'usuario'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2023-06-24 05:43:45.762771'),
(2, 'contenttypes', '0002_remove_content_type_name', '2023-06-24 05:43:45.802929'),
(3, 'auth', '0001_initial', '2023-06-24 05:43:45.989068'),
(4, 'auth', '0002_alter_permission_name_max_length', '2023-06-24 05:43:46.025728'),
(5, 'auth', '0003_alter_user_email_max_length', '2023-06-24 05:43:46.030106'),
(6, 'auth', '0004_alter_user_username_opts', '2023-06-24 05:43:46.034610'),
(7, 'auth', '0005_alter_user_last_login_null', '2023-06-24 05:43:46.039378'),
(8, 'auth', '0006_require_contenttypes_0002', '2023-06-24 05:43:46.042239'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2023-06-24 05:43:46.045419'),
(10, 'auth', '0008_alter_user_username_max_length', '2023-06-24 05:43:46.048635'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2023-06-24 05:43:46.051115'),
(12, 'auth', '0010_alter_group_name_max_length', '2023-06-24 05:43:46.099751'),
(13, 'auth', '0011_update_proxy_permissions', '2023-06-24 05:43:46.104605'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2023-06-24 05:43:46.107605'),
(15, 'core', '0001_initial', '2023-06-24 05:43:46.846978'),
(16, 'admin', '0001_initial', '2023-06-24 05:43:46.939609'),
(17, 'admin', '0002_logentry_remove_auto_add', '2023-06-24 05:43:46.949602'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2023-06-24 05:43:46.955365'),
(19, 'sessions', '0001_initial', '2023-06-24 05:43:46.975573'),
(20, 'core', '0002_alter_usuario_direccion', '2023-06-24 07:29:11.599385'),
(21, 'core', '0003_orden_direccion_envio', '2023-06-24 20:41:34.075059'),
(22, 'core', '0004_donacion', '2023-06-25 04:29:53.392768'),
(23, 'core', '0005_rename_monto_donado_donacion_monto_a_donar', '2023-06-25 04:46:02.709025'),
(24, 'core', '0006_alter_orden_creado_en_alter_orden_modificado_en', '2023-06-25 08:35:04.843705'),
(25, 'core', '0007_alter_orden_creado_en_alter_orden_modificado_en_and_more', '2023-06-25 08:45:36.903344');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

--
-- Volcado de datos para la tabla `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('ndpxh5k5ay5n0rus11e5b9ohbjnkxt2e', '.eJxVjEsOwjAMBe-SNYqcfpKaJXvOUDm2SwookZp2hbg7VOoCtm9m3suMtK1p3Kou4yzmbJw5_W6R-KF5B3KnfCuWS16XOdpdsQet9lpEn5fD_TtIVNO3jgqAnlkn74KSdl5x0B5ajegwemla7gKEiTGIE-qxkaAI4IMMhGTeH_r5OEo:1qDLog:qdhygF2KYISVQo9SIGODc5nMMLFSHXjC6ddptu8SooM', '2023-07-09 09:13:54.820952'),
('z8qskoxwebuafutmcjlwvo9z9sbjbyak', '.eJxVjEsOwjAMBe-SNYqcfpKaJXvOUDm2SwookZp2hbg7VOoCtm9m3suMtK1p3Kou4yzmbJw5_W6R-KF5B3KnfCuWS16XOdpdsQet9lpEn5fD_TtIVNO3jgqAnlkn74KSdl5x0B5ajegwemla7gKEiTGIE-qxkaAI4IMMhGTeH_r5OEo:1sT7gD:Hl6N-V0_zXpiLKRKtDxyQa05kP4GBhdcP8ctWy3bgsI', '2024-07-28 22:26:53.360123');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indices de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indices de la tabla `core_carrito`
--
ALTER TABLE `core_carrito`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_carrito_id_usuario_id_a8530b01_fk_core_usuario_id` (`id_usuario_id`),
  ADD KEY `core_carrito_producto_carrito_id_45e226fd_fk_core_producto_id` (`producto_carrito_id`);

--
-- Indices de la tabla `core_donacion`
--
ALTER TABLE `core_donacion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_donacion_id_usuario_id_d847a9b9_fk_core_usuario_id` (`id_usuario_id`);

--
-- Indices de la tabla `core_estadoorden`
--
ALTER TABLE `core_estadoorden`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `core_marca`
--
ALTER TABLE `core_marca`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `core_mensaje`
--
ALTER TABLE `core_mensaje`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `core_orden`
--
ALTER TABLE `core_orden`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_orden_estado_orden_id_6cc261ab_fk_core_estadoorden_id` (`estado_orden_id`),
  ADD KEY `core_orden_id_usuario_id_2ff524b5_fk_core_usuario_id` (`id_usuario_id`);

--
-- Indices de la tabla `core_ordenproducto`
--
ALTER TABLE `core_ordenproducto`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `core_ordenproducto_orden_id_producto_id_a51afedc_uniq` (`orden_id`,`producto_id`),
  ADD KEY `core_ordenproducto_producto_id_5b9951d7_fk_core_producto_id` (`producto_id`);

--
-- Indices de la tabla `core_producto`
--
ALTER TABLE `core_producto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_producto_marca_id_b2651e7a_fk_core_marca_id` (`marca_id`),
  ADD KEY `core_producto_tipo_id_e0e92ad1_fk_core_tipoproducto_id` (`tipo_id`);

--
-- Indices de la tabla `core_suscripcion`
--
ALTER TABLE `core_suscripcion`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_suscripcion_id_usuario_id_6d081176_fk_core_usuario_id` (`id_usuario_id`);

--
-- Indices de la tabla `core_tipoproducto`
--
ALTER TABLE `core_tipoproducto`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `core_usuario`
--
ALTER TABLE `core_usuario`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indices de la tabla `core_usuario_groups`
--
ALTER TABLE `core_usuario_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `core_usuario_groups_usuario_id_group_id_bde3c750_uniq` (`usuario_id`,`group_id`),
  ADD KEY `core_usuario_groups_group_id_55312a9a_fk_auth_group_id` (`group_id`);

--
-- Indices de la tabla `core_usuario_user_permissions`
--
ALTER TABLE `core_usuario_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `core_usuario_user_permis_usuario_id_permission_id_7a048d24_uniq` (`usuario_id`,`permission_id`),
  ADD KEY `core_usuario_user_pe_permission_id_7f881653_fk_auth_perm` (`permission_id`);

--
-- Indices de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_core_usuario_id` (`user_id`);

--
-- Indices de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indices de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=111;

--
-- AUTO_INCREMENT de la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT de la tabla `core_carrito`
--
ALTER TABLE `core_carrito`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT de la tabla `core_donacion`
--
ALTER TABLE `core_donacion`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT de la tabla `core_estadoorden`
--
ALTER TABLE `core_estadoorden`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `core_marca`
--
ALTER TABLE `core_marca`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `core_mensaje`
--
ALTER TABLE `core_mensaje`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `core_orden`
--
ALTER TABLE `core_orden`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `core_ordenproducto`
--
ALTER TABLE `core_ordenproducto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `core_producto`
--
ALTER TABLE `core_producto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT de la tabla `core_suscripcion`
--
ALTER TABLE `core_suscripcion`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `core_tipoproducto`
--
ALTER TABLE `core_tipoproducto`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `core_usuario`
--
ALTER TABLE `core_usuario`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT de la tabla `core_usuario_groups`
--
ALTER TABLE `core_usuario_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT de la tabla `core_usuario_user_permissions`
--
ALTER TABLE `core_usuario_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT de la tabla `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Filtros para la tabla `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Filtros para la tabla `core_carrito`
--
ALTER TABLE `core_carrito`
  ADD CONSTRAINT `core_carrito_id_usuario_id_a8530b01_fk_core_usuario_id` FOREIGN KEY (`id_usuario_id`) REFERENCES `core_usuario` (`id`),
  ADD CONSTRAINT `core_carrito_producto_carrito_id_45e226fd_fk_core_producto_id` FOREIGN KEY (`producto_carrito_id`) REFERENCES `core_producto` (`id`);

--
-- Filtros para la tabla `core_donacion`
--
ALTER TABLE `core_donacion`
  ADD CONSTRAINT `core_donacion_id_usuario_id_d847a9b9_fk_core_usuario_id` FOREIGN KEY (`id_usuario_id`) REFERENCES `core_usuario` (`id`);

--
-- Filtros para la tabla `core_orden`
--
ALTER TABLE `core_orden`
  ADD CONSTRAINT `core_orden_estado_orden_id_6cc261ab_fk_core_estadoorden_id` FOREIGN KEY (`estado_orden_id`) REFERENCES `core_estadoorden` (`id`),
  ADD CONSTRAINT `core_orden_id_usuario_id_2ff524b5_fk_core_usuario_id` FOREIGN KEY (`id_usuario_id`) REFERENCES `core_usuario` (`id`);

--
-- Filtros para la tabla `core_ordenproducto`
--
ALTER TABLE `core_ordenproducto`
  ADD CONSTRAINT `core_ordenproducto_orden_id_97cf6a78_fk_core_orden_id` FOREIGN KEY (`orden_id`) REFERENCES `core_orden` (`id`),
  ADD CONSTRAINT `core_ordenproducto_producto_id_5b9951d7_fk_core_producto_id` FOREIGN KEY (`producto_id`) REFERENCES `core_producto` (`id`);

--
-- Filtros para la tabla `core_producto`
--
ALTER TABLE `core_producto`
  ADD CONSTRAINT `core_producto_marca_id_b2651e7a_fk_core_marca_id` FOREIGN KEY (`marca_id`) REFERENCES `core_marca` (`id`),
  ADD CONSTRAINT `core_producto_tipo_id_e0e92ad1_fk_core_tipoproducto_id` FOREIGN KEY (`tipo_id`) REFERENCES `core_tipoproducto` (`id`);

--
-- Filtros para la tabla `core_suscripcion`
--
ALTER TABLE `core_suscripcion`
  ADD CONSTRAINT `core_suscripcion_id_usuario_id_6d081176_fk_core_usuario_id` FOREIGN KEY (`id_usuario_id`) REFERENCES `core_usuario` (`id`);

--
-- Filtros para la tabla `core_usuario_groups`
--
ALTER TABLE `core_usuario_groups`
  ADD CONSTRAINT `core_usuario_groups_group_id_55312a9a_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `core_usuario_groups_usuario_id_97385234_fk_core_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `core_usuario` (`id`);

--
-- Filtros para la tabla `core_usuario_user_permissions`
--
ALTER TABLE `core_usuario_user_permissions`
  ADD CONSTRAINT `core_usuario_user_pe_permission_id_7f881653_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `core_usuario_user_pe_usuario_id_ce4108a7_fk_core_usua` FOREIGN KEY (`usuario_id`) REFERENCES `core_usuario` (`id`);

--
-- Filtros para la tabla `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_core_usuario_id` FOREIGN KEY (`user_id`) REFERENCES `core_usuario` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
