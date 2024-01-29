//
//  ReportsViewController.swift
//  SternXTask
//
//  Created by farshad on 1/29/24.
//  Copyright © 2024 ifarshad.me. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt
import PureLayout
import RxDataSources

class ReportsViewController: UIViewController {
 
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var stateView: ContentStateView = {
        return .init(forAutoLayout: ())
    }()
    
    var viewModel: ReportViewModel?
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayouts()
        // Do any additional setup after loading the view.
    }
    
    private func setupLayouts() {
        setupCollectionViewLayout()
        setupContentStateView()
    }
    
    private func setupCollectionViewLayout() {
        let layout = createCompositionalLayout()
        collectionView.collectionViewLayout = layout
        collectionView.registerCell(type: TopUsersCollectionViewCell.self)
        collectionView.registerCell(type: ReportCollectionViewCell.self)
        collectionView.registerSupplementaryView(type: ReportCollectionViewCell.self,
                                                 kind: UICollectionView.elementKindSectionHeader)
    }
    
    private func setupContentStateView() {
        view.addSubview(stateView)
        stateView.autoPinEdgesToSuperviewSafeArea()
        stateView.isHidden = true
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, _) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0:
                return self.firstLayoutSection()
            default:
                return self.otherLayoutSection()
            }
        }
    }
    
    private func firstLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize) // Without badge
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalWidth(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16,
                                                        bottom: 16, trailing: 16)
        
        let supplementaryLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                             heightDimension: .estimated(44))
        let supplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementaryLayoutSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .bottomTrailing)
        section.boundarySupplementaryItems = [supplementary]
        return section
    }
    
    private func otherLayoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(50))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(CGFloat(8))
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        let supplementaryLayoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                             heightDimension: .estimated(44))
        
        let supplementary = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: supplementaryLayoutSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .bottomTrailing)
        section.boundarySupplementaryItems = [supplementary]
        return section
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func bind(to viewModel: ReportViewModel) {
        self.viewModel = viewModel
        loadViewIfNeeded()
        
        viewModel.isLoading.asObservable().bind(with: stateView) { view, isLoading in
            view.update(toState: isLoading ? .loading : .none, title: "Loading...",
                        description: "Getting information and generating report.", image: nil)
        }.disposed(by: disposeBag)
        viewModel.isLoading.drive(collectionView.rx.isHidden).disposed(by: disposeBag)
        viewModel.error.asObservable().bind(with: stateView) { view, error in
            view.update(toState: .error, title: "Error", description: error.localizedDescription,
                        image: UIImage(systemName: "exclamationmark.circle.fill")?.withRenderingMode(.alwaysTemplate))
        }.disposed(by: disposeBag)
        
        Driver.combineLatest(viewModel.isLoading, viewModel.items).asObservable().skip(1)
            .map { (isLoading: $0, count: $1.count) }
            .filter { !$0.isLoading && $0.count == 0 }
            .bind(with: self) { strongSelf, _ in
                strongSelf.stateView.update(toState: .empty, title: "Oops",
                                            description: "There is no users or post to display the report result.",
                                            image: UIImage(systemName: "doc.append")?.withRenderingMode(.alwaysTemplate))
            }.disposed(by: disposeBag)
        
    }
    
    private func dataSource() -> RxCollectionViewSectionedReloadDataSource<ReportViewModel.SectionType> {
        return RxCollectionViewSectionedReloadDataSource { _, collectionView, indexPath, viewModel in
            switch indexPath.section {
            case 0:
                let cell = collectionView.dequeueReusableCell(type: TopUsersCollectionViewCell.self,
                                                              forIndexPath: indexPath)
                if let viewModel = try? viewModel.reportTopUsersViewModel() {
                    cell.bind(to: viewModel)
                }
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(type: ReportCollectionViewCell.self,
                                                              forIndexPath: indexPath)
                if let viewModel = try? viewModel.reportUserViewModel() {
                    cell.bind(to: viewModel)
                }
                return cell
            }
        } configureSupplementaryView: { dataSource, collectionView, supplementaryKind, indexPath in
            guard supplementaryKind == UICollectionView.elementKindSectionHeader else {
                return UICollectionReusableView()
            }
            let view = collectionView.dequeueReusableSupplementaryView(type: ReportHeaderCollectionView.self,
                                                                       kind: supplementaryKind,
                                                                       forIndexPath: indexPath)
            view.titleLabel.text = dataSource.sectionModels[indexPath.section].model
            return view
        }
    }

}
