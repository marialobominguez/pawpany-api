-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Servidor: mysql-maria
-- Tiempo de generación: 12-05-2026 a las 17:22:48
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

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `Resenas`
--

CREATE TABLE `Resenas` (
  `id` int NOT NULL,
  `id_contrato` int NOT NULL,
  `calificacion` int DEFAULT NULL,
  `comentario` text,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ;

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
(1, 'patata_1234', 'patata1234@inventado.com', 'dsfkgahuujkew24@#', 'Patata', 'Asada', NULL, 'Madrid', 'dueño', '2026-05-08 11:22:02');

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
  ADD UNIQUE KEY `id_contrato` (`id_contrato`);

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
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Mascotas`
--
ALTER TABLE `Mascotas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Mensajes`
--
ALTER TABLE `Mensajes`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Perfiles_Cuidadores`
--
ALTER TABLE `Perfiles_Cuidadores`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Resenas`
--
ALTER TABLE `Resenas`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `Usuarios`
--
ALTER TABLE `Usuarios`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  ADD CONSTRAINT `Resenas_ibfk_1` FOREIGN KEY (`id_contrato`) REFERENCES `Contratos` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
