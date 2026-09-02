"""
Motor de cálculo de KPIs financieros, operativos y comerciales.

Cada fórmula es una función pura con tipos explícitos. Ninguna función
lanza excepciones: si un dato de entrada es inválido (por ejemplo un
denominador en cero, o una fecha de cierre anterior a la de inicio),
la función devuelve None y la interfaz muestra un mensaje de error.
"""

from dataclasses import dataclass
from datetime import date
from typing import Callable


def dividir_seguro(numerador: float, denominador: float) -> float | None:
    if denominador == 0:
        return None
    return numerador / denominador


def diferencia_en_dias(fecha_inicio: date, fecha_fin: date) -> int | None:
    if fecha_fin < fecha_inicio:
        return None
    return (fecha_fin - fecha_inicio).days


# ---------------------------------------------------------------------------
# KPIs financieros
# ---------------------------------------------------------------------------

def calcular_roi(beneficio: float, inversion: float) -> float | None:
    """Retorno sobre la inversión, en porcentaje."""
    proporcion = dividir_seguro(beneficio - inversion, inversion)
    if proporcion is None:
        return None
    return proporcion * 100


def calcular_margen_neto(utilidad_neta: float, ventas_totales: float) -> float | None:
    """Rentabilidad final sobre ventas, en porcentaje."""
    proporcion = dividir_seguro(utilidad_neta, ventas_totales)
    if proporcion is None:
        return None
    return proporcion * 100


def calcular_liquidez_corriente(activo_corriente: float, pasivo_corriente: float) -> float | None:
    """Capacidad de pago a corto plazo."""
    return dividir_seguro(activo_corriente, pasivo_corriente)


def calcular_punto_equilibrio(costos_fijos: float, precio: float, costo_variable_unitario: float) -> float | None:
    """Nivel de ventas (en unidades) sin pérdidas ni ganancias."""
    margen_contribucion = precio - costo_variable_unitario
    return dividir_seguro(costos_fijos, margen_contribucion)


def calcular_ebitda(utilidad_neta: float, impuestos: float, intereses: float, depreciacion: float, amortizacion: float) -> float:
    """Utilidad antes de intereses, impuestos, depreciación y amortización."""
    return utilidad_neta + impuestos + intereses + depreciacion + amortizacion


def calcular_roe(utilidad_neta: float, patrimonio: float) -> float | None:
    """Retorno sobre el patrimonio, en porcentaje."""
    proporcion = dividir_seguro(utilidad_neta, patrimonio)
    if proporcion is None:
        return None
    return proporcion * 100


def calcular_ratio_endeudamiento(pasivo_total: float, activo_total: float) -> float | None:
    """Proporción del activo financiada con deuda."""
    return dividir_seguro(pasivo_total, activo_total)


def calcular_flujo_caja_libre(flujo_operativo: float, capex: float) -> float:
    """Efectivo disponible tras la inversión en capital (CAPEX)."""
    return flujo_operativo - capex


# ---------------------------------------------------------------------------
# KPIs operativos
# ---------------------------------------------------------------------------

def calcular_productividad(unidades_producidas: float, horas_trabajadas: float) -> float | None:
    """Producción obtenida por hora trabajada."""
    return dividir_seguro(unidades_producidas, horas_trabajadas)


def calcular_rotacion_inventario(costo_ventas: float, inventario_promedio: float) -> float | None:
    """Veces que se renueva el inventario en un período."""
    return dividir_seguro(costo_ventas, inventario_promedio)


def calcular_tiempo_ciclo(fecha_inicio: date, fecha_entrega: date) -> int | None:
    """Duración total de un proceso operativo, en días."""
    return diferencia_en_dias(fecha_inicio, fecha_entrega)


def calcular_tasa_defectos(unidades_defectuosas: float, unidades_totales: float) -> float | None:
    """Porcentaje de unidades no conformes."""
    proporcion = dividir_seguro(unidades_defectuosas, unidades_totales)
    if proporcion is None:
        return None
    return proporcion * 100


def calcular_oee(disponibilidad: float, rendimiento: float, calidad: float) -> float:
    """Eficiencia global del equipo, en porcentaje. Los tres factores van de 0 a 1."""
    return disponibilidad * rendimiento * calidad * 100


def calcular_otif(entregas_a_tiempo_completas: float, entregas_totales: float) -> float | None:
    """Porcentaje de entregas a tiempo y completas."""
    proporcion = dividir_seguro(entregas_a_tiempo_completas, entregas_totales)
    if proporcion is None:
        return None
    return proporcion * 100


def calcular_costo_por_unidad(costo_total_produccion: float, unidades_producidas: float) -> float | None:
    """Costo de producir una sola unidad."""
    return dividir_seguro(costo_total_produccion, unidades_producidas)


def calcular_tiempo_inactividad(horas_paro: float, horas_programadas: float) -> float | None:
    """Porcentaje de horas programadas perdidas por paros."""
    proporcion = dividir_seguro(horas_paro, horas_programadas)
    if proporcion is None:
        return None
    return proporcion * 100


# ---------------------------------------------------------------------------
# KPIs comerciales
# ---------------------------------------------------------------------------

def calcular_tasa_conversion(clientes_nuevos: float, prospectos_totales: float) -> float | None:
    """Porcentaje de prospectos que se convierten en clientes."""
    proporcion = dividir_seguro(clientes_nuevos, prospectos_totales)
    if proporcion is None:
        return None
    return proporcion * 100


def calcular_cac(gasto_marketing_ventas: float, clientes_nuevos: float) -> float | None:
    """Costo de adquisición de cliente."""
    return dividir_seguro(gasto_marketing_ventas, clientes_nuevos)


def calcular_ltv(ticket_promedio: float, frecuencia_compra: float, duracion_relacion: float) -> float:
    """Valor de vida del cliente."""
    return ticket_promedio * frecuencia_compra * duracion_relacion


def calcular_ticket_promedio(ingresos_totales: float, numero_transacciones: float) -> float | None:
    """Monto medio por venta."""
    return dividir_seguro(ingresos_totales, numero_transacciones)


def calcular_tasa_retencion(clientes_al_inicio: float, clientes_perdidos: float) -> float | None:
    """Porcentaje de clientes retenidos en el período (100 − churn)."""
    churn = dividir_seguro(clientes_perdidos, clientes_al_inicio)
    if churn is None:
        return None
    return 100 - (churn * 100)


def calcular_roas(ingresos_por_publicidad: float, gasto_publicidad: float) -> float | None:
    """Retorno sobre la inversión publicitaria."""
    return dividir_seguro(ingresos_por_publicidad, gasto_publicidad)


def calcular_duracion_ciclo_venta(fecha_primer_contacto: date, fecha_cierre: date) -> int | None:
    """Días transcurridos entre el primer contacto y el cierre de la venta."""
    return diferencia_en_dias(fecha_primer_contacto, fecha_cierre)


def calcular_nps(promotores: float, detractores: float, total_encuestados: float) -> float | None:
    """Net Promoter Score, en una escala de -100 a 100."""
    proporcion = dividir_seguro(promotores - detractores, total_encuestados)
    if proporcion is None:
        return None
    return proporcion * 100


# ---------------------------------------------------------------------------
# Registro de KPIs para la interfaz
# ---------------------------------------------------------------------------

@dataclass
class CampoEntrada:
    etiqueta: str
    clave: str
    tipo: str = "numero"  # "numero" o "fecha"


@dataclass
class DefinicionKpi:
    nombre: str
    descripcion: str
    formula_texto: str
    campos: list[CampoEntrada]
    calcular: Callable[..., float | int | None]
    unidad: str = ""
    mensaje_error: str = "Revisa los datos ingresados: algún denominador es cero o una fecha es inconsistente."


REGISTRO_KPIS: dict[str, list[DefinicionKpi]] = {
    "Financieros": [
        DefinicionKpi(
            nombre="ROI — Retorno sobre la inversión",
            descripcion="Ganancia generada por cada unidad monetaria invertida.",
            formula_texto="(Beneficio − Inversión) / Inversión × 100",
            campos=[
                CampoEntrada("Beneficio obtenido", "beneficio"),
                CampoEntrada("Inversión realizada", "inversion"),
            ],
            calcular=calcular_roi,
            unidad="%",
        ),
        DefinicionKpi(
            nombre="Margen neto",
            descripcion="Rentabilidad final sobre ventas.",
            formula_texto="Utilidad neta / Ventas totales × 100",
            campos=[
                CampoEntrada("Utilidad neta", "utilidad_neta"),
                CampoEntrada("Ventas totales", "ventas_totales"),
            ],
            calcular=calcular_margen_neto,
            unidad="%",
        ),
        DefinicionKpi(
            nombre="Liquidez corriente",
            descripcion="Capacidad de pago a corto plazo.",
            formula_texto="Activo corriente / Pasivo corriente",
            campos=[
                CampoEntrada("Activo corriente", "activo_corriente"),
                CampoEntrada("Pasivo corriente", "pasivo_corriente"),
            ],
            calcular=calcular_liquidez_corriente,
        ),
        DefinicionKpi(
            nombre="Punto de equilibrio",
            descripcion="Nivel de ventas (en unidades) sin pérdidas ni ganancias.",
            formula_texto="Costos fijos / (Precio − Costo variable unitario)",
            campos=[
                CampoEntrada("Costos fijos", "costos_fijos"),
                CampoEntrada("Precio de venta unitario", "precio"),
                CampoEntrada("Costo variable unitario", "costo_variable_unitario"),
            ],
            calcular=calcular_punto_equilibrio,
            unidad="unidades",
        ),
        DefinicionKpi(
            nombre="EBITDA",
            descripcion="Utilidad antes de intereses, impuestos, depreciación y amortización.",
            formula_texto="Utilidad neta + Impuestos + Intereses + Depreciación + Amortización",
            campos=[
                CampoEntrada("Utilidad neta", "utilidad_neta"),
                CampoEntrada("Impuestos", "impuestos"),
                CampoEntrada("Intereses", "intereses"),
                CampoEntrada("Depreciación", "depreciacion"),
                CampoEntrada("Amortización", "amortizacion"),
            ],
            calcular=calcular_ebitda,
        ),
        DefinicionKpi(
            nombre="ROE — Retorno sobre el patrimonio",
            descripcion="Rentabilidad generada sobre el patrimonio de los socios.",
            formula_texto="Utilidad neta / Patrimonio × 100",
            campos=[
                CampoEntrada("Utilidad neta", "utilidad_neta"),
                CampoEntrada("Patrimonio", "patrimonio"),
            ],
            calcular=calcular_roe,
            unidad="%",
        ),
        DefinicionKpi(
            nombre="Ratio de endeudamiento",
            descripcion="Proporción del activo financiada con deuda.",
            formula_texto="Pasivo total / Activo total",
            campos=[
                CampoEntrada("Pasivo total", "pasivo_total"),
                CampoEntrada("Activo total", "activo_total"),
            ],
            calcular=calcular_ratio_endeudamiento,
        ),
        DefinicionKpi(
            nombre="Flujo de caja libre",
            descripcion="Efectivo disponible tras la inversión en capital (CAPEX).",
            formula_texto="Flujo operativo − CAPEX",
            campos=[
                CampoEntrada("Flujo de caja operativo", "flujo_operativo"),
                CampoEntrada("Inversión en capital (CAPEX)", "capex"),
            ],
            calcular=calcular_flujo_caja_libre,
        ),
    ],
    "Operativos": [
        DefinicionKpi(
            nombre="Productividad",
            descripcion="Producción obtenida por recurso empleado.",
            formula_texto="Unidades producidas / Horas trabajadas",
            campos=[
                CampoEntrada("Unidades producidas", "unidades_producidas"),
                CampoEntrada("Horas trabajadas", "horas_trabajadas"),
            ],
            calcular=calcular_productividad,
            unidad="unid./hora",
        ),
        DefinicionKpi(
            nombre="Rotación de inventario",
            descripcion="Veces que se renueva el inventario en un período.",
            formula_texto="Costo de ventas / Inventario promedio",
            campos=[
                CampoEntrada("Costo de ventas", "costo_ventas"),
                CampoEntrada("Inventario promedio", "inventario_promedio"),
            ],
            calcular=calcular_rotacion_inventario,
        ),
        DefinicionKpi(
            nombre="Tiempo de ciclo",
            descripcion="Duración total de un proceso operativo.",
            formula_texto="Fecha de entrega − Fecha de inicio del proceso",
            campos=[
                CampoEntrada("Fecha de inicio", "fecha_inicio", tipo="fecha"),
                CampoEntrada("Fecha de entrega", "fecha_entrega", tipo="fecha"),
            ],
            calcular=calcular_tiempo_ciclo,
            unidad="días",
            mensaje_error="La fecha de entrega no puede ser anterior a la fecha de inicio.",
        ),
        DefinicionKpi(
            nombre="Tasa de defectos",
            descripcion="Porcentaje de unidades no conformes.",
            formula_texto="Unidades defectuosas / Unidades totales × 100",
            campos=[
                CampoEntrada("Unidades defectuosas", "unidades_defectuosas"),
                CampoEntrada("Unidades totales", "unidades_totales"),
            ],
            calcular=calcular_tasa_defectos,
            unidad="%",
        ),
        DefinicionKpi(
            nombre="OEE — Eficiencia global del equipo",
            descripcion="Combina disponibilidad, rendimiento y calidad (cada uno de 0 a 1).",
            formula_texto="Disponibilidad × Rendimiento × Calidad × 100",
            campos=[
                CampoEntrada("Disponibilidad (0 a 1)", "disponibilidad"),
                CampoEntrada("Rendimiento (0 a 1)", "rendimiento"),
                CampoEntrada("Calidad (0 a 1)", "calidad"),
            ],
            calcular=calcular_oee,
            unidad="%",
        ),
        DefinicionKpi(
            nombre="OTIF — Entregas a tiempo y completas",
            descripcion="Porcentaje de entregas cumplidas sin retraso ni faltantes.",
            formula_texto="Entregas a tiempo y completas / Entregas totales × 100",
            campos=[
                CampoEntrada("Entregas a tiempo y completas", "entregas_a_tiempo_completas"),
                CampoEntrada("Entregas totales", "entregas_totales"),
            ],
            calcular=calcular_otif,
            unidad="%",
        ),
        DefinicionKpi(
            nombre="Costo por unidad",
            descripcion="Costo de producir una sola unidad.",
            formula_texto="Costo total de producción / Unidades producidas",
            campos=[
                CampoEntrada("Costo total de producción", "costo_total_produccion"),
                CampoEntrada("Unidades producidas", "unidades_producidas"),
            ],
            calcular=calcular_costo_por_unidad,
        ),
        DefinicionKpi(
            nombre="Tiempo de inactividad",
            descripcion="Porcentaje de horas programadas perdidas por paros.",
            formula_texto="Horas de paro / Horas programadas × 100",
            campos=[
                CampoEntrada("Horas de paro", "horas_paro"),
                CampoEntrada("Horas programadas", "horas_programadas"),
            ],
            calcular=calcular_tiempo_inactividad,
            unidad="%",
        ),
    ],
    "Comerciales": [
        DefinicionKpi(
            nombre="Tasa de conversión",
            descripcion="Porcentaje de prospectos que se convierten en clientes.",
            formula_texto="Clientes nuevos / Prospectos totales × 100",
            campos=[
                CampoEntrada("Clientes nuevos", "clientes_nuevos"),
                CampoEntrada("Prospectos totales", "prospectos_totales"),
            ],
            calcular=calcular_tasa_conversion,
            unidad="%",
        ),
        DefinicionKpi(
            nombre="CAC — Costo de adquisición de cliente",
            descripcion="Costo de conseguir un cliente nuevo.",
            formula_texto="Gasto en marketing y ventas / Clientes nuevos",
            campos=[
                CampoEntrada("Gasto en marketing y ventas", "gasto_marketing_ventas"),
                CampoEntrada("Clientes nuevos", "clientes_nuevos"),
            ],
            calcular=calcular_cac,
        ),
        DefinicionKpi(
            nombre="LTV — Valor de vida del cliente",
            descripcion="Ingreso total esperado de un cliente durante la relación.",
            formula_texto="Ticket promedio × Frecuencia de compra × Duración de relación",
            campos=[
                CampoEntrada("Ticket promedio", "ticket_promedio"),
                CampoEntrada("Frecuencia de compra (por período)", "frecuencia_compra"),
                CampoEntrada("Duración de relación (en períodos)", "duracion_relacion"),
            ],
            calcular=calcular_ltv,
        ),
        DefinicionKpi(
            nombre="Ticket promedio",
            descripcion="Monto medio por venta.",
            formula_texto="Ingresos totales / Número de transacciones",
            campos=[
                CampoEntrada("Ingresos totales", "ingresos_totales"),
                CampoEntrada("Número de transacciones", "numero_transacciones"),
            ],
            calcular=calcular_ticket_promedio,
        ),
        DefinicionKpi(
            nombre="Tasa de retención",
            descripcion="Porcentaje de clientes retenidos en el período (100 − churn).",
            formula_texto="100 − (Clientes perdidos / Clientes al inicio × 100)",
            campos=[
                CampoEntrada("Clientes al inicio del período", "clientes_al_inicio"),
                CampoEntrada("Clientes perdidos", "clientes_perdidos"),
            ],
            calcular=calcular_tasa_retencion,
            unidad="%",
        ),
        DefinicionKpi(
            nombre="ROAS — Retorno sobre inversión publicitaria",
            descripcion="Ingreso generado por cada unidad monetaria invertida en publicidad.",
            formula_texto="Ingresos por publicidad / Gasto en publicidad",
            campos=[
                CampoEntrada("Ingresos generados por publicidad", "ingresos_por_publicidad"),
                CampoEntrada("Gasto en publicidad", "gasto_publicidad"),
            ],
            calcular=calcular_roas,
        ),
        DefinicionKpi(
            nombre="Duración del ciclo de venta",
            descripcion="Días entre el primer contacto y el cierre de la venta.",
            formula_texto="Fecha de cierre − Fecha de primer contacto",
            campos=[
                CampoEntrada("Fecha de primer contacto", "fecha_primer_contacto", tipo="fecha"),
                CampoEntrada("Fecha de cierre", "fecha_cierre", tipo="fecha"),
            ],
            calcular=calcular_duracion_ciclo_venta,
            unidad="días",
            mensaje_error="La fecha de cierre no puede ser anterior a la del primer contacto.",
        ),
        DefinicionKpi(
            nombre="NPS — Net Promoter Score",
            descripcion="Mide la lealtad y probabilidad de recomendación de los clientes.",
            formula_texto="(Promotores − Detractores) / Total de encuestados × 100",
            campos=[
                CampoEntrada("Clientes promotores (calificación 9-10)", "promotores"),
                CampoEntrada("Clientes detractores (calificación 0-6)", "detractores"),
                CampoEntrada("Total de encuestados", "total_encuestados"),
            ],
            calcular=calcular_nps,
            unidad="puntos",
        ),
    ],
}
