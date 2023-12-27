class UserInfo {
  const UserInfo({
    required this.avatar,
    required this.href,
    required this.id,
    required this.name,
  });

  final String avatar;
  final String name;
  final String id;
  final String href;

  factory UserInfo.formJson(Map<String, dynamic> map) => UserInfo(
        avatar: map['avatar'],
        href: map['href'],
        id: map['id'],
        name: map['name'],
      );
}
