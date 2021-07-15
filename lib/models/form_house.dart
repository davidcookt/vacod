class FormHouse {
  String? id, title;
  bool? isSelected;
  FormHouse({this.id, this.title, this.isSelected});
}

const defaultFormHouse = [
  {
    'id': 'NC',
    'title': 'Nhà nguyên căn',
    'isSelected': false,
  },
  {
    'id': 'NT',
    'title': 'Nhà trọ',
    'isSelected': false,
  },
  {
    'id': 'CH',
    'title': 'Cửa hàng',
    'isSelected': false,
  },
  {
    'id': 'KH',
    'title': 'Khác',
    'isSelected': false,
  }
];
