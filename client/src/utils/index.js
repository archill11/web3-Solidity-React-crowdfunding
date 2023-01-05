/**
 * ������� ���� ���������� �� ����
 * @param {*} deadline 
 * @returns 
 */
export const daysLeft = (deadline) => {
  const difference = new Date(deadline).getTime() - Date.now();
  const remainingDays = difference / (1000 * 3600 * 24);

  return remainingDays.toFixed(0);
};

/**
 * ������� ����������� ������� ����� ���� ������������ � ��������� �� ����� ����� ������
 * @param {*} goal 
 * @param {*} raisedAmount 
 * @returns 
 */
export const calculateBarPercentage = (goal, raisedAmount) => {
  const percentage = Math.round((raisedAmount * 100) / goal);

  return percentage;
};

/**
 * �������� ���������� ����������� ������� ����������� � ��������
 * @param {*} url 
 * @param {*} callback 
 */
export const checkIfImage = (url, callback) => {
  const img = new Image();
  img.src = url;

  if (img.complete) callback(true);

  img.onload = () => callback(true);
  img.onerror = () => callback(false);
};