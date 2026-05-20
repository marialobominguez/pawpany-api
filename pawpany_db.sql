-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: mysql-maria
-- Tiempo de generación: 20-05-2026 a las 13:49:48
-- Versión del servidor: 9.5.0
-- Versión de PHP: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `pawpany_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Contratos`
--

CREATE TABLE `Contratos` (
  `id` int NOT NULL,
  `id_dueno` int NOT NULL,
  `id_cuidador` int NOT NULL,
  `fecha_inicio` datetime NOT NULL,
  `fecha_fin` datetime NOT NULL,
  `estado` enum('Pendiente','Aceptado','Rechazado','Completado','Cancelado') DEFAULT 'Pendiente',
  `precio_total` decimal(8,2) DEFAULT NULL,
  `detalles_servicio` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Contratos`
--

INSERT INTO `Contratos` (`id`, `id_dueno`, `id_cuidador`, `fecha_inicio`, `fecha_fin`, `estado`, `precio_total`, `detalles_servicio`) VALUES
(1, 1, 3, '2026-05-22 13:03:24', '2026-05-27 13:03:24', 'Pendiente', 500.00, 'a tiempo completo');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Mascotas`
--

CREATE TABLE `Mascotas` (
  `id` int NOT NULL,
  `id_usuario` int NOT NULL,
  `foto_url` varchar(255) DEFAULT NULL,
  `nombre` varchar(100) NOT NULL,
  `especie` varchar(100) DEFAULT NULL,
  `raza` varchar(100) DEFAULT NULL,
  `fecha_nacimiento` date DEFAULT NULL,
  `requisitos_tags` json DEFAULT NULL,
  `personalidad_libre` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Mascotas`
--

INSERT INTO `Mascotas` (`id`, `id_usuario`, `foto_url`, `nombre`, `especie`, `raza`, `fecha_nacimiento`, `requisitos_tags`, `personalidad_libre`) VALUES
(1, 3, 'https://static.vecteezy.com/system/resources/thumbnails/023/103/916/small_2x/not-available-rubber-stamp-seal-vector.jpg', 'Nano', 'perro', 'bichón maltés', '2013-06-16', '[\"muchos mimos\", \"jugar a la pelota\"]', 'le gusta mucho jugar a la pelota y dormir todo el día');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Mensajes`
--

CREATE TABLE `Mensajes` (
  `id` int NOT NULL,
  `id_remitente` int NOT NULL,
  `id_destinatario` int NOT NULL,
  `contenido` text NOT NULL,
  `fecha_envio` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `leido` tinyint(1) DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Mensajes`
--

INSERT INTO `Mensajes` (`id`, `id_remitente`, `id_destinatario`, `contenido`, `fecha_envio`, `leido`) VALUES
(1, 1, 3, 'holaaaa', NULL, 0),
(2, 3, 1, 'adiooos-_-', '2026-05-20 13:20:13', 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Perfiles_Cuidadores`
--

CREATE TABLE `Perfiles_Cuidadores` (
  `id` int NOT NULL,
  `id_usuario` int NOT NULL,
  `foto_url` varchar(255) DEFAULT NULL,
  `estudios` varchar(255) NOT NULL,
  `cualidades_tags` json DEFAULT NULL,
  `sobre_mi` text,
  `tarifa` decimal(6,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Perfiles_Cuidadores`
--

INSERT INTO `Perfiles_Cuidadores` (`id`, `id_usuario`, `foto_url`, `estudios`, `cualidades_tags`, `sobre_mi`, `tarifa`) VALUES
(1, 1, 'https://i.pinimg.com/236x/f0/f2/e1/f0f2e1cc01756eebf219e8aaa92ed1a2.jpg', 'ATV', '[\"experiencia con gatos\", \"experiencia con cachorros\", \"experiencia con cobayas\"]', 'soy una persona energética a la que le apasionan todos los animales', 10.50);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Resenas`
--

CREATE TABLE `Resenas` (
  `id` int NOT NULL,
  `id_contrato` int NOT NULL,
  `id_autor` int NOT NULL,
  `calificacion` int DEFAULT NULL,
  `comentario` text,
  `fecha_creacion` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Resenas`
--

INSERT INTO `Resenas` (`id`, `id_contrato`, `id_autor`, `calificacion`, `comentario`, `fecha_creacion`) VALUES
(1, 1, 3, 5, 'Muy buen cuidador, definitivamente lo recomiendo. Ha tratado muy bien a Nano', '2026-05-20 13:48:04');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Usuarios`
--

CREATE TABLE `Usuarios` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido1` varchar(100) NOT NULL,
  `apellido2` varchar(100) DEFAULT NULL,
  `ubicacion` varchar(150) DEFAULT NULL,
  `rol` enum('dueño','cuidador') NOT NULL,
  `fecha_registro` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Volcado de datos para la tabla `Usuarios`
--

INSERT INTO `Usuarios` (`id`, `username`, `email`, `password_hash`, `nombre`, `apellido1`, `apellido2`, `ubicacion`, `rol`, `fecha_registro`) VALUES
(1, 'patata_1234', 'patata1234@inventado.com', 'dsfkgahuujkew24@#', 'Patata', 'Asada', NULL, 'Madrid', 'dueño', '2026-05-08 11:22:02'),
(2, 'mariiia18', 'marialobodam@gmail.com', 'fjiahrgbiuyfhdu124*', 'María', 'Lobo', 'Mínguez', 'Móstoles', 'dueño', NULL),
(3, '2maria2', '2marialobodam2@gmail.com', 'fjiahrgbiuyfhdu1242*', 'María2', 'Lobo2', 'Mínguez2', 'Móstoles2', 'dueño', '2026-05-15 17:27:44'),
(6, 'asfesdsag', 'usgegdasgrer@example.com', 'strgdsgaarehering', 'rgregr', 'strsdagrring', 'rgaregr', 'striturjdng', 'dueño', '2026-05-17 09:34:52');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `Contratos`
--
ALTER TABLE `Contratos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_dueno` (`id_dueno`),
  ADD KEY `id_cuidador` (`id_cuidador`);

--
-- Indices de la tabla `Mascotas`
--
ALTER TABLE `Mascotas`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `Mensajes`
--
ALTER TABLE `Mensajes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_remitente` (`id_remitente`),
  ADD KEY `id_destinatario` (`id_destinatario`);

--
-- Indices de la tabla `Perfiles_Cuidadores`
--
ALTER TABLE `Perfiles_Cuidadores`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id_usuario` (`id_usuario`);

--
-- Indices de la tabla `Resenas`
--
ALTER TABLE `Resenas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_contrato` (`id_contrato`),
  ADD KEY `id_autor` (`id_autor`);

--
-- Indices de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `Contratos`
--
ALTER TABLE `Contratos`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `Mascotas`
--
ALTER TABLE `Mascotas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `Mensajes`
--
ALTER TABLE `Mensajes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `Perfiles_Cuidadores`
--
ALTER TABLE `Perfiles_Cuidadores`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `Resenas`
--
ALTER TABLE `Resenas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `Contratos`
--
ALTER TABLE `Contratos`
  ADD CONSTRAINT `Contratos_ibfk_1` FOREIGN KEY (`id_dueno`) REFERENCES `Usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Contratos_ibfk_2` FOREIGN KEY (`id_cuidador`) REFERENCES `Usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Mascotas`
--
ALTER TABLE `Mascotas`
  ADD CONSTRAINT `Mascotas_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Mensajes`
--
ALTER TABLE `Mensajes`
  ADD CONSTRAINT `Mensajes_ibfk_1` FOREIGN KEY (`id_remitente`) REFERENCES `Usuarios` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Mensajes_ibfk_2` FOREIGN KEY (`id_destinatario`) REFERENCES `Usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Perfiles_Cuidadores`
--
ALTER TABLE `Perfiles_Cuidadores`
  ADD CONSTRAINT `Perfiles_Cuidadores_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `Usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `Resenas`
--
ALTER TABLE `Resenas`
  ADD CONSTRAINT `Resenas_ibfk_1` FOREIGN KEY (`id_contrato`) REFERENCES `Contratos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `Resenas_ibfk_2` FOREIGN KEY (`id_autor`) REFERENCES `Usuarios` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
