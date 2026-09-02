
"""
Calculadora de KPIs financieros, operativos y comerciales.
 
Ejecutar con: streamlit run app.py
"""
 
from datetime import date
 
import streamlit as st
 
from kpi_engine import REGISTRO_KPIS, DefinicionKpi
 
COLOR_POR_CATEGORIA: dict[str, str] = {
    "Financieros": "#0C447C",
    "Operativos": "#085041",
    "Comerciales": "#72243E",
}
 
 
def leer_valores_entrada(kpi: DefinicionKpi) -> dict[str, float | date]:
    valores: dict[str, float | date] = {}
    for campo in kpi.campos:
        if campo.tipo == "fecha":
            valores[campo.clave] = st.date_input(campo.etiqueta, key=f"{kpi.nombre}-{campo.clave}")
        else:
            valores[campo.clave] = st.number_input(campo.etiqueta, key=f"{kpi.nombre}-{campo.clave}", value=0.0, step=1.0)
    return valores
 
 
def formatear_resultado(resultado: float, unidad: str) -> str:
    if unidad == "%":
        return f"{resultado:,.2f} %"
    if unidad == "días":
        return f"{int(resultado)} días"
    if unidad:
        return f"{resultado:,.2f} {unidad}"
    return f"{resultado:,.2f}"
 
 
def mostrar_kpi(kpi: DefinicionKpi, color: str) -> None:
    with st.expander(kpi.nombre, expanded=False):
        st.caption(kpi.descripcion)
        st.markdown(f"**Fórmula:** `{kpi.formula_texto}`")
 
        valores = leer_valores_entrada(kpi)
 
        if st.button("Calcular", key=f"boton-{kpi.nombre}"):
            resultado = kpi.calcular(**valores)
            if resultado is None:
                st.error(kpi.mensaje_error)
            else:
                st.markdown(
                    f"<div style='background:{color}1a;border-left:4px solid {color};"
                    f"padding:10px 14px;border-radius:6px;margin-top:8px;'>"
                    f"<span style='color:{color};font-weight:700;font-size:18px;'>"
                    f"{formatear_resultado(resultado, kpi.unidad)}</span></div>",
                    unsafe_allow_html=True,
                )
 
 
def main() -> None:
    st.set_page_config(page_title="Calculadora de KPIs", page_icon="📊", layout="centered")
    st.title("📊 Calculadora de KPIs")
    st.caption("Financieros, operativos y comerciales — selecciona una categoría y despliega el KPI que necesitas calcular.")
 
    pestanas = st.tabs(list(REGISTRO_KPIS.keys()))
 
    for pestana, categoria in zip(pestanas, REGISTRO_KPIS.keys()):
        with pestana:
            color = COLOR_POR_CATEGORIA[categoria]
            for kpi in REGISTRO_KPIS[categoria]:
                mostrar_kpi(kpi, color)
 
 
if __name__ == "__main__":
    main()
 
