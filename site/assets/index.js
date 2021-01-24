function getQuickReport(isLast, isMonth) {
  let dt = new Date();
  let linkPath;
  if (isMonth) {
    if (isLast) {
      dt.setMonth(dt.getMonth() - 1);
    }
  }
  else {
    if (isLast) {
      dt.setDate(dt.getDate() - 1);
    }
  }

  let y = dt.getFullYear();
  let m = `${dt.getMonth() + 1}`.padStart(2, "0");
  let d = dt.getDate();
  linkPath = `${y}/${m}/${d}`;
  if (isMonth) {
    linkPath = `${y}/${m}`;
  }

  window.open(`https://${window.location.hostname}/report/${linkPath}/report.html`);
}

function getReport(isDaily) {
  let dateStr = document.getElementById('date').value;
  if (dateStr == 'undefined' || dateStr == '') {
    alert("Input Date, Please."); 
    return;
  }
  let datePath = dateStr.replaceAll('-', '/');
  let path = datePath;
  if (!isDaily) {
    path = datePath.split('/').slice(0, 2).join('/');
  }
  
  window.open(`https://${window.location.hostname}/report/${path}/report.html`);
}
