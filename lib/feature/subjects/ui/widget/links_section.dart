import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kursovaya_notebook/feature/link/data/model/link_data_model.dart';
import 'package:kursovaya_notebook/feature/subjects/bloc/subject_cubit.dart';
import 'package:kursovaya_notebook/feature/subjects/ui/widget/add_link_button.dart';
import 'package:url_launcher/url_launcher.dart';

class LinksSection extends StatelessWidget {
  final List<LinkData> links;
  final String folderId;
  final int subjectId;

  const LinksSection({
    super.key,
    required this.links,
    required this.folderId,
    required this.subjectId,
  });

  Future<void> _launchUrl(BuildContext context, String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Не удалось открыть ссылку')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Ссылки:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (links.isEmpty)
          const Text(
            'Нет добавленных ссылок',
            style: TextStyle(color: Colors.grey),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children:
                links.asMap().entries.map((entry) {
                  final index = entry.key;
                  final link = entry.value;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => _launchUrl(context, link.url),
                        icon: const Icon(Icons.link, size: 16),
                        label: Text(link.name),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, size: 20),
                        onPressed:
                            () => context
                                .read<SubjectCubit>()
                                .removeLinkFromSubject(
                                  folderId,
                                  subjectId,
                                  index,
                                ),
                      ),
                    ],
                  );
                }).toList(),
          ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: AddLinkButton(folderId: folderId, subjectId: subjectId),
        ),
      ],
    );
  }
}
