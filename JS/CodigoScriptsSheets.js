const pages = await report.getPages();
pages.forEach(p => {
    console.log(`displayName: ${p.displayName}, pageName: ${p.name}`);
});
const newSettings = {
    panes: {
        filters: {
            visible: false
        },
        pageNavigation: {
            visible: false
        }
    }
};
try {
    await report.updateSettings(newSettings);
    console.log("Filter pane was removed.");
}
catch (error) {
    console.log(error);
}

/*Codigo solicitud bajo pedido*/


function importarSheetsActasRecepcion() {
  const origenId = '1tWpV3lYYNmYaBBUWy-aClayI1E9w53QKYeLH5vtBOEI';
  const hojaOrigen = SpreadsheetApp.openById(origenId).getSheetByName('Actas de Recepcion');
  const hojaDestino = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('ACTAS');
  const data = hojaOrigen.getDataRange().getValues();
  const columnasDeseadas = [5, 6, 7, 13, 25, 26];
  const dataDesdeFila1501 = data.slice(49000);
  const resultado = dataDesdeFila1501.map(fila => columnasDeseadas.map(i => fila[i] ?? ""));
  hojaDestino.clearContents();
  hojaDestino.getRange(2, 1, resultado.length, columnasDeseadas.length).setValues(resultado);
}

function importarExcelMaestroClientes() {
  const origenId = '1B8jr222VZ7-eI-9vfJbehVC-YAGmL66g';
  const hojaDestino = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('MAESTRO CLIENTES');
  const file = DriveApp.getFileById(origenId);
  const blob = file.getBlob();
  const archivoTemporal = Drive.Files.insert({
    title: "TemporalConvertido",
    mimeType: MimeType.GOOGLE_SHEETS
  }, blob);
  const temporalId = archivoTemporal.id;
  const hojaOrigen = SpreadsheetApp.openById(temporalId).getSheetByName('ClientesApi');
  const data = hojaOrigen.getDataRange().getValues();
  const columnasDeseadas = [0, 1, 3, 24];
  const resultado = data.map(fila => columnasDeseadas.map(i => fila[i] ?? ""));
  hojaDestino.clearContents();
  hojaDestino.getRange(1, 1, resultado.length, columnasDeseadas.length).setValues(resultado);
  DriveApp.getFileById(temporalId).setTrashed(true);
  Logger.log('Ejecucion terminada correctamente');
}

function importarExcelCartagotado() {
  const fileId = '12mXewKOdcBEJI9qFEoXqnmDi-TkfMrAw';
  const hojaDestino = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('CARTA AGOTADO');
  const file = DriveApp.getFileById(fileId);
  const blob = file.getBlob();
  const archivoTemporal = Drive.Files.insert({
    title: "TemporalConvertido",
    mimeType: MimeType.GOOGLE_SHEETS
  }, blob);
  const temporalId = archivoTemporal.id;
  const hojaOrigen = SpreadsheetApp.openById(temporalId).getSheetByName('Hoja2');
  const data = hojaOrigen.getDataRange().getValues();
  const columnasDeseadas = [0, 1, 6];
  const resultado = data.map(fila => columnasDeseadas.map(i => {
    let valor = fila[i];
    if ((i === 0 || i === 6) && valor instanceof Date) {
      return Utilities.formatDate(valor, Session.getScriptTimeZone(), 'dd/MM/yyyy');
    }
    return valor ?? "";
  }));
  hojaDestino.clearContents();
  hojaDestino.getRange(1, 1, resultado.length, columnasDeseadas.length).setValues(resultado);
  DriveApp.getFileById(temporalId).setTrashed(true);
  Logger.log('✅ Importación completa y archivo temporal eliminado.');
}

function importarExcelFacturacionAcumulada() {
  const origenId = '1I7CEAQVc_q1gtShVzNsku5ODTCp9GH8k';
  const hojaDestino = SpreadsheetApp.getActiveSpreadsheet().getSheetByName('FACTURACION');
  const file = DriveApp.getFileById(origenId);
  const blob = file.getBlob();
  const archivoTemporal = Drive.Files.insert({
    title: "TemporalConvertido",
    mimeType: MimeType.GOOGLE_SHEETS
  }, blob);
  const temporalId = archivoTemporal.id;
  const hojaOrigen = SpreadsheetApp.openById(temporalId).getSheetByName('Acumulado Documentos');
  const data = hojaOrigen.getDataRange().getValues();
  const columnasDeseadas = [0, 1, 5];
  const resultado = data.map(fila => columnasDeseadas.map(i => fila[i] ?? ""));
  hojaDestino.clearContents();
  hojaDestino.getRange(1, 1, resultado.length, columnasDeseadas.length).setValues(resultado);
  DriveApp.getFileById(temporalId).setTrashed(true);
  Logger.log('Ejecucion terminada correctamente');
}


