class FormService {
  String? id, title;
  bool? isSelected;

  FormService({this.id, this.title, this.isSelected});
}

const defaultFormService = [
  {
    'id': '0',
    'title': 'Điện',
    'isSelected': false,
  },
  {
    'id': '1',
    'title': 'Nước',
    'isSelected': false,
  },
  {
    'id': '2',
    'title': 'Vệ sinh',
    'isSelected': false,
  },
  {
    'id': '3',
    'title': 'Internet',
    'isSelected': false,
  },
  {
    'id': '4',
    'title': 'Cáp',
    'isSelected': false,
  },
  {
    'id': '5',
    'title': 'Gửi xe',
    'isSelected': false,
  },
  {
    'id': '6',
    'title': 'Phí khác',
    'isSelected': false,
  },
];
